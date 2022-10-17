Clearance.configure do |config|
  config.routes = false
  config.mailer_sender = "admin@yalit.io"
  config.rotate_csrf_on_sign_in = true
end
