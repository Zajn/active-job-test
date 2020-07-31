# frozen_string_literal: true

namespace :delayed_job do
  desc 'Starts DJ and enqueues the test mailer job'

  task mail: :environment do
    TestMailer.test.deliver_later
    Rake::Task['jobs:work'].invoke

    trap('SIGINT') { throw :ctrl_c }

    catch :ctrl_c do
      puts 'Clearing DJ Queue'
      Rake::Task['jobs:clear'].invoke
    end
  end
end
