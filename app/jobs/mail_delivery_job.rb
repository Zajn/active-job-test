# frozen_string_literal: true

class MailDeliveryJob < ActionMailer::DeliveryJob
  def max_run_time
    1.second
  end
end
