require 'rails_helper'

describe "Sign in flow" do

  include TestFactories

  before do
    @user = test_user
  end

  describe "successful non-admin sign-in" do
    it "redirects the user to limbo" do
      user = @user
      visit root_path

      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password

      within 'form' do
        click_button 'Log in'
      end

      expect(current_path).to eq limbo_path
      expect(page).to have_css('#limbo-message')
      print ("\nNon-admin sign-in passed")
    end
  end

  describe "successful admin sign-in" do

    before do
      @user.update_attributes(:role => 'admin')
      @user.save!
    end

    it "redirects the admin user to the welcome index and shows tools" do
      user = @user
      visit root_path

      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password

      within 'form' do
        click_button 'Log in'
      end

      expect(current_path).to eq root_path
      expect(page).to have_css('.admin-link')
      print ("\nAdmin sign-in passed")
    end
  end


  describe "successful reviewer sign-in" do

    before do
      @user.update_attributes(:role => 'reviewer')
      @user.save!
    end

    it "redirects the reviewer user to the review panel" do
      user = @user
      visit root_path

      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password

      within 'form' do
        click_button 'Log in'
      end

      expect(current_path).to eq practices_review_index_path
      print ("\nReviewer sign-in passed")
    end
  end

end
