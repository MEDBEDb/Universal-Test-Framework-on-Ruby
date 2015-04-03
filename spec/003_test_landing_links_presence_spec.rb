require "rubygems"
require "watir-webdriver"
require "rspec"

brws = File.read("brws.txt").split("\n")[0]
environment = File.read("env.txt").split("\n")[0]
url ="SET YOUR WEBSITE TREE URL"
browser = Watir::Browser.new brws.to_s.gsub('"','')
browser.goto url

describe "The test will validate all the expected landing page presence:" do
  before(:each) do 
    browser.goto url
  end

  after(:all) do	  
  	browser.close
  end
  
  after(:each) do
    if example.exception != nil
      puts "Failed....."
      browser.driver.save_screenshot "#{__FILE__}".to_s.split("/").last[0..2]+" "+browser.url.split("/").last.to_s+" Test Step - "+browser.title.to_s+" - Failed - "+Time.now.to_s.gsub(":","-")+".jpg"
    else
      puts "Passed!"
	  browser.driver.save_screenshot "#{__FILE__}".to_s.split("/").last[0..2]+" "+browser.url.split("/").last.to_s+" Test Step - "+browser.title.to_s+" - Passed - "+Time.now.to_s.gsub(":","-")+".jpg"    end
  end
    
  it 'Check all expected categories and links presence' do
	linkz = ["Link1",
	"Link 2",
	"Link 3",
	"Link N"]

    linkz.each do |x| 
   	  browser.text.should include (x) 
    end
  end
end