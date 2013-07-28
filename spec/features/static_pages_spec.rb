require 'spec_helper'
include ApplicationHelper

describe "Static pages" do
  let(:base_title) { "Ruby on Rails Tutorial Sample App" }
  subject { page }
  
  describe "Home page" do
    before { visit root_path }
    
    it { should have_selector('h1', text: 'Sample App') }
    it { should have_title("#{base_title}")}
    
    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end
    end
  end   

  describe "Help page" do
    before { visit help_path }
    
    it { should have_selector('h1', text: 'Help') }
    it { should have_title("#{base_title} | Help") }
  end

  describe "About page" do
    before { visit about_path }
    it { should have_selector('h1', text: 'About Us') }
    it { should have_title("#{base_title} | About Us") }
  end
  
  describe "Contacts page" do
    before { visit contact_path }
    it { should have_selector('h1', text: 'Contact') }
    it { should have_title("#{base_title} | Contact") }
  end
  
  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    page.should have_title full_title("About Us") #just for test
    click_link "Help"
    page.should have_title "#{base_title} | Help"
    click_link "Contact"
    page.should have_title "#{base_title} | Contact"
    click_link "Home"
    click_link "Sign up now!"
    page.should have_title "#{base_title} | Sign up"
    click_link "sample app"
    page.should have_title "#{base_title}"
  end
end