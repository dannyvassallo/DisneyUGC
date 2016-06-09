require 'rails_helper'

describe "Campaign View Security Tests" do

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

  describe "Anon tries to visit a dead campaign" do
    before do
      logout(@user)
    end
    it "shows Anon the error page" do
      visit campaign_path(@dead_campaign)
      expect(@dead_campaign).to render_template(:partial =>'campaigns/_error')
      print ("\nAnon was not shown the dead campaign")
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

  describe "Anon visits live campaign" do
    before do
      logout(@user)
    end
    it "shows Anon the campaign without admin tools" do
      visit campaign_path(@live_campaign)
      expect(page).to_not have_css('#admin-tools')
      print ("\nAnon couldn't see admin tools on a live campaign")
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

  describe "Non-admin user tries to visit campaign index" do
    it "shows the user the error page" do
      visit campaigns_path
      expect(campaigns_path).to render_template(:partial =>'campaigns/_error')
      print ("\nUser was not shown the campaign index")
    end
  end

  describe "Anon tries to visit campaign index" do
    before do
      logout(@user)
    end
    it "shows Anon the error page" do
      visit campaigns_path
      expect(campaigns_path).to render_template(:partial =>'campaigns/_error')
      print ("\nAnon was not shown the campaign index")
    end
  end

  describe "Admin user tries to visit campaign index" do
    before do
      @user.update_attributes(:role => 'admin')
      @user.save!
    end
    it "shows the admin the campaign index" do
      visit campaigns_path
      expect(campaigns_path).to_not render_template(:partial =>'campaigns/_error')
      expect(campaigns_path).to render_template(:partial =>'campaigns/_campaign')
      print ("\nAdmin was shown the campaign index")
    end
  end

  describe "Non-admin user tries to visit new campaign path" do
    it "shows the user the error page" do
      visit new_campaign_path
      expect(new_campaign_path).to render_template(:partial =>'campaigns/_error')
      print ("\nUser was not shown the new campaign path")
    end
  end

  describe "Anon tries to visit new campaign path" do
    before do
      logout(@user)
    end
    it "shows Anon the error page" do
      visit new_campaign_path
      expect(new_campaign_path).to render_template(:partial =>'campaigns/_error')
      print ("\nAnon was not shown the new campaign path")
    end
  end

  describe "Admin user tries to visit new campaign path" do
    before do
      @user.update_attributes(:role => 'admin')
      @user.save!
    end
    it "shows the admin the campaign new campaign path" do
      visit new_campaign_path
      expect(new_campaign_path).to_not render_template(:partial =>'campaigns/_error')
      print ("\nAdmin was shown the new campaign path")
    end
  end

  describe "Non-admin user tries to visit edit campaign path" do
    it "shows the user the error page" do
      visit edit_campaign_path(@live_campaign)
      expect(edit_campaign_path(@live_campaign)).to render_template(:partial =>'campaigns/_error')
      print ("\nUser was not shown the edit campaign path")
    end
  end

  describe "Anon tries to visit edit campaign path" do
    before do
      logout(@user)
    end
    it "shows Anon the error page" do
      visit edit_campaign_path(@live_campaign)
      expect(edit_campaign_path(@live_campaign)).to render_template(:partial =>'campaigns/_error')
      print ("\nAnon was not shown the edit campaign path")
    end
  end

  describe "Admin user tries to visit edit campaign path" do
    before do
      @user.update_attributes(:role => 'admin')
      @user.save!
    end
    it "shows the admin the edit campaign path" do
      visit edit_campaign_path(@live_campaign)
      expect(edit_campaign_path(@live_campaign)).to_not render_template(:partial =>'campaigns/_error')
      print ("\nAdmin was shown the edit campaign path")
    end
  end

end
