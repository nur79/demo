require 'spec_helper'

describe "Static Pages" do

  describe "Home Page" do

  	it "should have the right title" do 
  		visit home_path 
  		page.should have_selector('title', text: " | Home")
  	end

    it "should have the content 'Sample App'" do
      visit home_path
      page.should have_selector("h1", text: "Sample App")
    end
  end

  describe "Help Page" do

  	it "should have the right title" do 
  		visit help_path 
  		page.should have_selector('title', text: " | Help")
  	end

  	it "should have the content 'Help'" do 
  		visit help_path 
  		page.should have_content("Help")
  	end 
  end

  describe "About Page" do

  	it "should have the right title" do 
  		visit about_path 
  		page.should have_selector('title', text: " | About Us")
  	end

  	it "should have the content 'About Us'" do 
  		visit about_path 
  		page.should have_content("About Us")
  	end 
  end
end
