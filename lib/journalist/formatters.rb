Dir[File.join(File.dirname(__FILE__), 'formatters/*.rb')].each { |lib| require lib }
module Journalist
  module Formatters
  end
end