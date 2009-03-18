require File.expand_path(File.dirname(__FILE__) + '/spec_helper.rb')

describe Uaid::Extractor do
  before :all do
    @extractor = Uaid::Extractor.new
  end
  
  {
    ["unknown", "unknown", "x"] => [nil, '', ' '],
    ["webkit", "safari", "3"] => [
      "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_2; en-us) AppleWebKit/526+ (KHTML, like Gecko) Version/3.1.1 Safari/525.18",
      "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.18 (KHTML, like Gecko) Version/3.1.1 Safari/525.17"],
    ["webkit", "chrome", "1"] => [
      "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.13 (KHTML, like Gecko) Chrome/0.A.B.C Safari/525.13",
      "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.19 (KHTML, like Gecko) Chrome/1.0.154.36 Safari/525.19"],
    ["webkit", "safari", "4"] => [
      "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_6; en-us) AppleWebKit/528.16 (KHTML, like Gecko) Version/4.0 Safari/528.16"],
    ["gecko", "firefox", "2"] => [
      "Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-US; rv:1.8.1.14) Gecko/20080404 Firefox/2.0.0.14",
      "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.6) Gecko/20060601 Firefox/2.0.0.6 (Ubuntu-edgy)",
      "Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.8.1.4) Gecko/20080721 BonEcho/2.0.0.4"],
    ["gecko", "firefox", "3"] => [
      "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.0.1) Gecko/2008070206 Firefox/3.0.1",
      "Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090109 Shiretoko/3.1b3pre"],
    ["ie", "ie", "8"] => [
      "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; WOW64; SLCC1; .NET CLR 2.0.50727; .NET CLR 3.0.04506; Media Center PC 5.0; .NET CLR 1.1.4322)"],
    ["ie", "ie", "7"] => [
      "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.0.04506; InfoPath.1)",
      "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)"],
    ["ie", "ie", "6"] => [
      "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)"],
    ["webkit", "mobilesafari", "3"] => [
      "Mozilla/5.0 (iPhone; U; XXXXX like Mac OS X; en) AppleWebKit/420+ (KHTML, like Gecko) Version/3.0 Mobile/241 Safari/419.3"],
    ["webkit", "android", "0"] => [
      "Mozilla/5.0 (Linux; U; Android 0.5; en-us) AppleWebKit/522+ (KHTML, like Gecko) Safari/419.3"],
    ["unknown", "unknown", "x"] => [
      "Mozilla/4.0",
      "VB Project"],
    ["unknown", "bot", "x"] => [
      "ia_archiver",
      "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)",
      "Googlebot/2.1 (+http://www.googlebot.com/bot.html)",
      "Googlebot/2.1 (+http://www.google.com/bot.html)",
      "msnbot/1.0 (+http://search.msn.com/msnbot.htm)"]
  }.each do |expected, agents| agents.each do |agent|
      
      it "should identify #{agent.inspect} as #{expected.inspect}" do
        @extractor.extract(agent).should == expected
      end
      
  end; end
end