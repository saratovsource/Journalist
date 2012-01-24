#!/usr/bin/env rake
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end
begin
  require 'rdoc/task'
rescue LoadError
  require 'rdoc/rdoc'
  require 'rake/rdoctask'
  RDoc::Task = Rake::RDocTask
end
require 'bundler'
Bundler.setup

require 'rake'
require 'rspec'
require 'rspec/core/rake_task'
require 'rubygems/package_task'
require 'tasks/state_machine'
$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

gemspec = eval(File.read('journalist.gemspec'))
Gem::PackageTask.new(gemspec) do |pkg|
  pkg.gem_spec = gemspec
end

desc 'build the gem and release it to rubygems.org'
task :release => :gem do
  sh "gem push pkg/journalist-#{gemspec.version}.gem"
end

%w(unit integration models).each do |task_var|
  RSpec::Core::RakeTask.new("spec:#{task_var}") do |spec|
    spec.pattern = "spec/#{task_var}/**/*_spec.rb"
  end
end

task :spec => %w(unit integration models).collect{|i| "spec:#{i}"}

task :default => :spec

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Journalist'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end



Bundler::GemHelper.install_tasks

