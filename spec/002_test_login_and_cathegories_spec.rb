require "rubygems"
require "watir-webdriver"
require "rspec"

brws = File.read("brws.txt").split("\n")[0]
environment = File.read("env.txt").split("\n")[0]
url ="SET YOUR WEBSITE TREE URL"
browser = Watir::Browser.new brws.to_s.gsub('"','')
browser.goto url

describe "The test will validate that valid user can login successfully and main page should contain main categories:" + " GIVEN SET OF TEXT STRUCTURES AND CATEGORIES IN DOM." do
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
      browser.driver.save_screenshot "#{__FILE__}".to_s.split("/").last[0..2]+" "+browser.url.split("/").last.to_s+" Test Step - "+browser.title.to_s+" - Passed - "+Time.now.to_s.gsub(":","-")+".jpg"
    end
  end

it "Valid user can login successfully and main page should not return an invalid error message containing main categories: GIVEN SET OF TEXT STRUCTURES AND CATEGORIES IN DOM" do
	browser.text.should_not include("The requested URL could not be retrieved")
	browser.text.should include("DEFINE CATEGORY 1")
	browser.text.should include("DEFINE CATEGORY 2")
	#browser.driver.save_screenshot "#{__FILE__}".to_s.split("/").last+" Test Step - "+browser.title+".jpg"
	end
end