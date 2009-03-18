require File.expand_path(File.dirname(__FILE__) + '/spec_helper.rb')

describe Uaid::UserAgent do
  {
    ["noagent", "x", false] => [nil, '', ' '],
    ["webkit", "3", true] => [
      "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_2; en-us) AppleWebKit/526+ (KHTML, like Gecko) Version/3.1.1 Safari/525.18",
      "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.18 (KHTML, like Gecko) Version/3.1.1 Safari/525.17",
      "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.13 (KHTML, like Gecko) Chrome/0.A.B.C Safari/525.13",
      "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.19 (KHTML, like Gecko) Chrome/1.0.154.36 Safari/525.19"],
    ["webkit", "4", true] => [
      "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_6; en-us) AppleWebKit/528.16 (KHTML, like Gecko) Version/4.0 Safari/528.16"],
    ["gecko", "2", true] => [
      "Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-US; rv:1.8.1.14) Gecko/20080404 Firefox/2.0.0.14",
      "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.6) Gecko/20060601 Firefox/2.0.0.6 (Ubuntu-edgy)",
      "Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.8.1.4) Gecko/20080721 BonEcho/2.0.0.4"],
    ["gecko", "3", true] => [
      "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.0.1) Gecko/2008070206 Firefox/3.0.1"],
    ["gecko", "3.5", true] => [
      "Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090109 Shiretoko/3.1b3pre"],
    ["ie", "8", true] => [
      "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; WOW64; SLCC1; .NET CLR 2.0.50727; .NET CLR 3.0.04506; Media Center PC 5.0; .NET CLR 1.1.4322)"],
    ["ie", "7", true] => [
      "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.0.04506; InfoPath.1)",
      "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)"],
    ["ie", "6", false] => [
      "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)"],
    ["mobilesafari", "3", true] => [
      "Mozilla/5.0 (iPhone; U; XXXXX like Mac OS X; en) AppleWebKit/420+ (KHTML, like Gecko) Version/3.0 Mobile/241 Safari/419.3"],
    ["unknown", "x", false] => [
      "Mozilla/4.0",
      "VB Project"],
    ["bot", "x", true] => [
      "ia_archiver",
      "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)",
      "Googlebot/2.1 (+http://www.googlebot.com/bot.html)",
      "Googlebot/2.1 (+http://www.google.com/bot.html)",
      "msnbot/1.0 (+http://search.msn.com/msnbot.htm)"]
  }.each do |expected_name_version_supported, agents| agents.each do |agent|
      
      it "should indicate #{agent.inspect} as #{expected_name_version_supported[0..1].inspect}, #{expected_name_version_supported.last ? 'a supported' : 'an unsupported'} browser" do
        user_agent = Uaid::UserAgent.new(agent)
        user_agent.name.should == expected_name_version_supported[0]
        user_agent.version.should == expected_name_version_supported[1]
        user_agent.supported?.should == expected_name_version_supported[2]
      end
      
  end; end
end

describe Uaid::UserAgent, 'name question' do
  it 'should answer true when agent has name' do
    user_agent = Uaid::UserAgent.new('unknown')
    user_agent.webkit?.should be_false
    user_agent.unknown?.should be_true
  end
end