require 'rails_helper'

describe "Sign in flow" do

  include TestFactories

  describe "successful non-admin sign-in" do
    it "redirects the user to the welcome index" do
      user = non_admin_user
      visit root_path

      within '.nav-wrapper .right' do
        click_link 'Login'
      end
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password

      within 'form' do
        click_button 'Log in'
      end

      expect(current_path).to eq root_path
      expect(page).to_not have_css('.admin-link')
      print ("\nNon-admin sign-in passed")
    end
  end

  describe "successful non-admin sign-in" do
    it "redirects the admin user to the welcome index" do
      user = admin_user
      visit root_path

      within '.nav-wrapper .right' do
        click_link 'Login'
      end
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

end