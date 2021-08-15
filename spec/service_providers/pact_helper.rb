# frozen_string_literal: true

require "pact/consumer/rspec"
# or require 'pact/consumer/minitest' if you are using Minitest

Pact.configure do |config|
  config.pactfile_write_mode = :overwrite
end

Pact.service_consumer "Monitoui App" do
  has_pact_with "Monitoapi App" do
    mock_service :monito do
      port 1234
    end
  end
end
