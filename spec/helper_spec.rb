require File.expand_path(File.dirname(__FILE__) + '/spec_helper.rb')
require 'ostruct'

describe Uaid::Helper do
  include Uaid::Helper
  
  attr_reader :request
  
  it 'should provide a user_agent from the current request' do
    @request = OpenStruct.new(:headers => {'user-agent' => 'whatever'})
    user_agent.should_not be_nil
    user_agent.name.should == 'unknown'
  end
end