require File.expand_path(File.dirname(__FILE__) + '/spec_helper.rb')

describe Uaid::UserAgent, 'identification questions' do
  before do
    @user_agent = Uaid::UserAgent.new('unknown')
  end
  
  after do
    Uaid.supported_agents = nil
  end
  
  [
    ['unknown', 'bot', '1.0'],
    ['webkit', 'unknown', '1'],
    ['webkit', 'bot', 'x'],
  ].each do |attributes|
    engine, product, version = attributes
    it "should answer true for unknown when unknown as #{attributes.inspect}" do
      user_agent = Uaid::UserAgent.new('unknown')
      stub(@user_agent).engine { engine }
      stub(@user_agent).product { product }
      stub(@user_agent).version { Uaid::Version.new(version) }
      @user_agent.unknown?.should be_true
    end
  end
  
  it 'should answer false for unknown when all attributes are known' do
    stub(@user_agent).engine { 'someengine' }
    stub(@user_agent).product { 'someproduct' }
    stub(@user_agent).version { Uaid::Version.new('1.0') }
    @user_agent.unknown?.should be_false
  end
  
  it 'should answer for engine' do
    stub(@user_agent).engine { 'someengine' }
    @user_agent.someengine?.should be_true
    @user_agent.otherengine?.should be_false
  end
  
  it 'should answer for product' do
    stub(@user_agent).product { 'someproduct' }
    @user_agent.someproduct?.should be_true
    @user_agent.otherproduct?.should be_false
    
    stub(@user_agent).product { 'noagent' }
    @user_agent.bot?.should be_false
  end
  
  it 'should answer for version' do
    stub(@user_agent).version { Uaid::Version.new('2.0') }
    @user_agent.version?('2').should be_true
  end
  
  it 'should answer an identifier which include the engine, product and major version' do
    stub(@user_agent).engine { 'someengine' }
    stub(@user_agent).product { 'someproduct' }
    stub(@user_agent).version { Uaid::Version.new('5.5') }
    @user_agent.identifier.should == 'someengine someproduct someproduct5 someproduct5-5'
  end
  
  it 'should answer supported as true when all attributes match a supported agent' do
    stub(@user_agent).engine { 'webkit' }
    stub(@user_agent).product { 'safari' }
    stub(@user_agent).version { Uaid::Version.new('3.0') }
    @user_agent.should be_supported
  end
  
  it 'should answer supported when an entry in the supported list is a regular expression' do
    Uaid.supported_agents = [/safari [34]/]
    stub(@user_agent).product { 'safari' }
    stub(@user_agent).version { Uaid::Version.new('3.0') }
    @user_agent.should be_supported
    
    stub(@user_agent).version { Uaid::Version.new('4.0') }
    @user_agent.should be_supported
    
    stub(@user_agent).version { Uaid::Version.new('2.0') }
    @user_agent.should_not be_supported
  end

  it 'should respond true when chromeframe is in agent string' do
    user_agent = Uaid::UserAgent.new('... chromeframe ...')
    user_agent.should be_chromeframe 
  end

  it 'should respond false when chromeframe is not in agent string' do
    user_agent = Uaid::UserAgent.new('unknown')
    user_agent.should_not be_chromeframe 
  end

end
