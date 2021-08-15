# frozen_string_literal: true
require "rspec_api_documentation"
require "rspec_api_documentation/dsl"

RspecApiDocumentation.configure do |config|
  # Set the application that Rack::Test uses
  config.app = Rails.application

  # Output folder
  API_VERSIONS.each do |version|
    config.define_group(version) do |conf|
      # Filter by example document type
      conf.filter = version

      # An array of output format(s).
      # Possible values are :json, :html, :combined_text, :combined_json,
      #   :json_iodocs, :textile, :markdown, :append_json, :slate
      conf.format = [:json]

      conf.docs_dir = Rails.root.join("doc", "api", version.to_s)
    end
  end

  config.format = [:json]

  # Filter by example document type
  config.exclusion_filter = nil

  # By default examples and resources are ordered by description. Set to true keep
  # the source order.
  config.keep_source_order = true

  # Change the name of the API on index pages
  config.api_name = "Monito API Documentation"

  # Change how the post body is formatted by default, you can still override by `raw_post`
  # Can be :json, :xml, or a proc that will be passed the params
  config.request_body_formatter = :json

  config.disable_dsl_status!

  # Change how the response body is formatted by default
  # Is proc that will be called with the response_content_type & response_body
  # by default response_content_type of `application/json` are pretty formated.
  # config.response_body_formatter = Proc.new { |response_content_type, response_body| response_body }
end
