require 'rails_helper'

describe "Campaign Security Tests" do

  include TestFactories  
  
  before do     
    @user = test_user
    @dead_campaign = dead_test_campaign
    @live_campaign = live_test_campaign        
    visit root_path

    within '.nav-wrapper .right' do
      click_link 'Login'
    end
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password

    within 'form' do
      click_button 'Log in'
    end
  end

  describe "Non-admin user tries to visit a dead campaign" do
    it "shows the user the error page" do                
      visit campaign_path(@dead_campaign)
      expect(@dead_campaign).to render_template(:partial =>'campaigns/_error')
      print ("\nUser was not shown the dead campaign")
    end
  end

  describe "Admin user tries to visit a dead campaign" do
    before do      
      @user.update_attributes(:role => 'admin')
      @user.save!
    end
    it "shows the admin the dead campaign" do
      visit campaign_path(@dead_campaign)
      expect(@dead_campaign).to_not render_template(:partial =>'campaigns/_error')
      print ("\nAdmin was shown the dead campaign")
    end
  end

  describe "Non-admin user visits live campaign" do  
    it "shows the user the campaign without admin tools" do
      visit campaign_path(@live_campaign)
      expect(page).to_not have_css('#admin-tools')
      print ("\nNon-admin couldn't see admin tools on a live campaign")
    end
  end

  describe "Admin user visits live campaign" do
    before do      
      @user.update_attributes(:role => 'admin')
      @user.save!
    end 
    it "Shows the admin the campaign with admin tools visible" do
      visit campaign_path(@live_campaign)
      expect(page).to have_css('#admin-tools')
      print ("\nAdmin could see admin tools on a live campaign")
    end
  end

end