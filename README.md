# Steps to reproduce

1. Check out repository and run `bundle`.
2. Run the database migrations

## Demonstrating the per-job customizations are ignored

1. Run `bundle exec rake delayed_job:mail`
2. See that the job is enqueued and run successfully, despite the `MailDeliveryJob` having a `max_run_time` of 1 second

## Demonstrating the desired behavior with the monkey patch

1. Run `bundle exec rake delayed_job:mail[true]`
2. See that the job is enqueued but fails to run, because the execution time is longer than the permitted `max_run_time` declared in `MailDeliveryJob`. (ignore that DJ incorrectly reports the default max run time at the console of 14400 seconds which is a known issue with DJ).

