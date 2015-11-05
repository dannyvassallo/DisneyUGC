require 'rails_helper'

describe "Campaign Security Tests" do

  include TestFactories  
  
  before do
    @campaign = test_campaign
    @user = test_user
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
      visit campaign_path(@campaign)
      expect(campaign_path(@campaign)).to render_template('campaigns/_error')
      print ("\nNon-admin couldn't see dead campaign and was served the custom error page")
    end
  end

end