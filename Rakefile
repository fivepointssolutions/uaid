require 'rake'
require 'rake/rdoctask'
require 'spec/rake/spectask'

task :default => :spec

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "uaid"
    s.summary = "A small library useful to Rack-based Ruby applications for obtaining information about the user agent"
    s.email = "adam@thewilliams.ws"
    s.homepage = "http://github.com/fivepointssolutions/uaid"
    s.description = s.summary
    s.authors = ["Adam Williams"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

desc "Run all specs"
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = ['--options', 'spec/spec.opts']
end

Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'uaid'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end