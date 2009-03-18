SPEC_ROOT = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH << (SPEC_ROOT + '/../lib')

require 'rubygems'
require 'rr'
require 'spec'

Spec::Runner.configure do |config|
  config.mock_with :rr
end

require 'uaid'