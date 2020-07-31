# frozen_string_literal: true

module ActiveJob
  module QueueAdapters
    class DelayedJobAdapter
      def enqueue(job)
        delayed_job = Delayed::Job.enqueue(JobWrapper.new(job), queue: job.queue_name, priority: job.priority)
        job.provider_job_id = delayed_job.id
        delayed_job
      end

      class JobWrapper
        attr_accessor :original_job, :job_data

        delegate :max_run_time, to: :original_job

        def initialize(job)
          @original_job = job
          @job_data = job.serialize
        end

        def display_name
          "#{job_data['job_class']} [#{job_data['job_id']}] from DelayedJob(#{job_data['queue_name']}) with arguments: #{job_data['arguments']}"
        end

        def perform
          Base.execute(job_data)
        end
      end
    end
  end
end
