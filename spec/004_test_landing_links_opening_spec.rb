require "rubygems"
require "watir-webdriver"
require "rspec"

def move_screenshots
  @tm = Time.now.to_s.gsub(":","-")[0..14]
  env = File.read("env.txt").split("\n")[0]
  dir = FileUtils.pwd
  screen_dir = Dir["#{dir}/*.jpg"]
  log_dir = Dir["#{dir}/*.log"]
  a = "logs/"
  b = env.to_s+" "+@tm.to_s+" run"
  @dest_folder = a.to_s+b.to_s 
  @dup_files = dir+"/"+@dest_folder.to_s+"/*"

  if Dir['logs/*'].include? "logs/"+b
    FileUtils.rm_rf(Dir.glob(@dup_files))
    puts "Removed old screenshots. Moved new screenshots to #{dir}/#{@dest_folder}"
  else
    puts "Moved the screenshots to #{dir}/#{@dest_folder}"
  end 
  screen_dir.each do |x| 
    name = File.basename('x', '.jpg')
      if Dir['logs/*'].include? "logs/"+b
        FileUtils.move(x, @dest_folder)
      else
        FileUtils.mkdir @dest_folder
        FileUtils.move(x, @dest_folder)
    end
  end
end

brws = File.read("brws.txt").split("\n")[0]
environment = File.read("env.txt").split("\n")[0]
url ="SET YOUR WEBSITE TREE URL"
browser = Watir::Browser.new brws.to_s.gsub('"','')
browser.goto url

describe "The test will validate that all the links (besides: ADD EXCEPTIONS WITH TITLE MISSMATCH) on the main page are opening, the title of each corresponds to the expected value and there are no errors/exceptions" do
	before(:each) do 
		browser.goto url
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

  after(:all) do
    browser.close
    move_screenshots
  end

links_right=[]; links_left=[]; links_slow=[]; links_full=[]
browser.links.each do |x| 
 if x.text.empty? or x.text.nil? or x.text == "Link 1 to be skipped Out of scope" or x.text == "Link 2 OOO" or x.text.include? "Link 3 OOO" #Skipping, BA requested to not include these two into smoke  
  next
 elsif x.text == "Link 3 OOO" or x.text == "Link 4 OOO" or x.text == "Link 5 OOO" #x.text == "Dashboard Reports" #Skipping, intentional/fail skip/out of scope
  next
 elsif x.text == "Link 1 check only last word - RIGHT PART" or x.text == "Link 2 check only last word - RIGHT PART"
  links_right.push(x.text)
 elsif  x.text == "Link 1 check only first word - LEFT PART" or x.text == "Link 2 check only first word - LEFT PART" 
  links_left.push(x.text)
 elsif x.text == "Link 1 Slow opening" or x.text == "Link 2 Slow opening" 
  links_slow.push(x.text)
 else
  links_full.push(x.text)
  end
end

links_right.each do |x|
    it "Check #{x} opening & loading." do
      browser.link(:text, x).click
      browser.text.should_not include ("Not Found")
      browser.text.should_not include("The requested URL could not be retrieved")
      browser.text.should_not include ("java.lang.RuntimeException")
      browser.title.should include (x.split(" ").last)
      browser.text.should include (x.split(" ").last)
    end
  end

  links_left.each do |x|
    it "Check #{x} opening & loading." do
      browser.link(:text, x).click
      browser.text.should_not include ("Not Found")
      browser.text.should_not include("The requested URL could not be retrieved")
      browser.text.should_not include ("java.lang.RuntimeException")
      browser.title.should include (x.split(" ").first)
      browser.text.should include (x.split(" ").first)
    end
  end

  links_slow.each do |x|
    it "Check #{x} opening & loading." do
      browser.link(:text, x).click
      browser.title.should include (x)
    end
  end

  links_full.each do |x|
    it "Check #{x} opening & loading." do
      browser.link(:text, x).click
      browser.text.should_not include ("Not Found")
      browser.text.should_not include("The requested URL could not be retrieved")
      browser.text.should_not include ("java.lang.RuntimeException")
      browser.title.should include (x)
      browser.text.should include (x)
    end
  end
end