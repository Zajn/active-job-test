# frozen_string_literal: true

class TestMailer < ApplicationMailer
  def test
    sleep 5
    mail(to: 'example@example.com', subject: 'Hello')
  end
end
