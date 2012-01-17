source "http://rubygems.org"

# Declare your gem's dependencies in journalist.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# jquery-rails is used by the dummy application
gem "jquery-rails"
group :development do
  gem 'haml'
  gem 'rspec-rails'
  gem 'unicorn'
  gem 'rspec-cells'
end

group :test, :development do
  gem 'linecache', '0.43', :platforms => :mri_18
  gem 'ruby-debug', :platforms => :mri_18
  gem 'ruby-debug19', :platforms => :mri_19
end

group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  
  gem 'database_cleaner'
  
  gem 'spork'
  gem 'launchy'
  gem 'mocha'
end

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
