require File.expand_path(File.dirname(__FILE__) + '/spec_helper.rb')

describe Uaid::Version do
  it 'parse standard string' do
    v('1.2').major.should == 1  
    v('1.2').minor.should == 2  
    v('1.2b').minor.should == 2  
    
    v('1.2').major_string.should == '1'  
    v('1.2').minor_string.should == '2'
    v('1.2b').minor_string.should == '2b'  
  end

  it 'compare with strings and regexps' do
    v('1.1').should == '1.1'
    v('1.1').should =~ /1/
    v('1.1').match(/1/)[0].should == '1'
  end

  it 'compare greater than' do
    v('1.1').should > '1'
    v('1.1').should > 1.0
    v('2').should > v('1')
    v('1.1').should > v('1.0')
    v('1.2').should > v('1.1')
  end

  it 'compare equal' do
    v('1.1').should == '1.1'
    v('1.1').should == 1.1
    v('1.1').should == v('1.1')
    v('1.1').should == v('1.01')
    v('1.1').should == v('1.1b')
  end

  it 'compare less than' do
    v('1.1').should < '1.2'
    v('1.1').should < 1.2
    v('1.1').should < v('1.2')
  end

  def v(string)
    Uaid::Version.new(string)
  end
end

