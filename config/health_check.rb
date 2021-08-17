HealthCheck.setup do |config|

  # uri prefix (no leading slash)
  config.uri = 'health_check'

  # Text output upon success
  config.success = 'success'

  # Text output upon failure
  config.failure = 'health_check failed'

  # Disable the error message to prevent /health_check from leaking
  # sensitive information
  config.include_error_in_response_body = false

  # http status code used when plain text error message is output
  # Set to 200 if you want your want to distinguish between partial (text does not include success) and
  # total failure of rails application (http status of 500 etc)

  config.http_status_for_error_text = 500

  # http status code used when an error object is output (json or xml)
  # Set to 200 if you want to distinguish between partial (healthy property == false) and
  # total failure of rails application (http status of 500 etc)

  config.http_status_for_error_object = 500

  # You can customize which checks happen on a standard health check, eg to set an explicit list use:
  config.standard_checks = [ 'database', 'migrations' ]

  # max-age of response in seconds
  # cache-control is public when max_age > 1 and basic_auth_username is not set
  # You can force private without authentication for longer max_age by
  # setting basic_auth_username but not basic_auth_password
  config.max_age = 1

  # Protect health endpoints with basic auth
  # These default to nil and the endpoint is not protected
  config.basic_auth_username = 'monito-admin'
  config.basic_auth_password = 'm1n2t3'
end
