require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "dm-chrome-history"
  gem.homepage = "http://github.com/knowtheory/dm-chrome-history"
  gem.license = "MIT"
  gem.summary = %Q{Search your Google Chrome history }
  gem.description = %Q{Spelunk your browsing history with the help of your good buddy DataMapper}
  gem.email = "gems@knowtheory.net"
  gem.authors = ["Ted Han"]
  gem.add_runtime_dependency 'dm-core',            '~>1.0'
  gem.add_runtime_dependency 'dm-validations',     '~>1.0'
  gem.add_runtime_dependency 'dm-types',           '~>1.0'
  gem.add_runtime_dependency 'dm-aggregates',      '~>1.0'
  gem.add_runtime_dependency 'dm-sqlite-adapters', '~>1.0'

  gem.add_development_dependency 'rspec', '> 1.2.3'
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new
