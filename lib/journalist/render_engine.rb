require File.join(File.dirname(__FILE__), 'render_engine/abstract_engine.rb')
Dir[File.join(File.dirname(__FILE__), 'render_engine/*.rb')].each { |lib| require lib }
