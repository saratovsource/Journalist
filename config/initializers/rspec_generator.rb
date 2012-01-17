if Rails.env.test? && defined?(Journalist::Application) # does not need it for the engine version
  Journalist::Application.configure do
    config.generators do |g|
      g.integration_tool :rspec
      g.test_framework   :rspec
    end
  end
end