# Steps to reproduce

1. Check out repository and run `bundle`.
2. Run the database migrations

## Demonstrating the per-job customizations are ignored

1. Comment out `lib/active_job/queue_adapters/delayed_job_adapter.rb`
2. Run `bundle exec rake delayed_job:mail`
3. See that the job is enqueued and run successfully, despite the `MailDeliveryJob` having a `max_run_time` of 1 second

## Demonstrating the desired behavior with the monkey patch

1. Uncomment the monkey patch if commented out from above
2. Run `bundle exec rake delayed_job:mail`
3. See that the job is enqueued but fails to run, because the execution time is longer than the permitted `max_run_time` ddeclared in `MailDeliveryJob`.
