RSpec.configure do |config|
  config.include Warden::Test::Helpers, type: :feature
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.after(type: :feature) { Warden.test_reset! }
end
