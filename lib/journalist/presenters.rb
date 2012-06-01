require File.join(File.dirname(__FILE__), 'presenters/presenter.rb')
Dir[File.join(File.dirname(__FILE__), 'presenters/*.rb')].each { |lib| require lib }
