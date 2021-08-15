# frozen_string_literal: true
module Regexmn
  ## Email Regex
  #
  EMAIL_FORMAT = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i.freeze
  ## Password Regex
  #
  PASSWORD_FORMAT = /\A(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}\z/.freeze
end
