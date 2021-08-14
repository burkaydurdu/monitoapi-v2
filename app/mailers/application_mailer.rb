# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "monito@example.com"
  layout "mailer"
end
