require 'rails_helper'

describe CampaignsController do

  include TestFactories  
  include Devise::TestHelpers

  before do
    @user = create(:user)    
    @user.save!
    sign_in @user
  end

  describe '#create' do
    it "attempts to create a campaign as non-admin" do
      post :create, campaign: { title: 'Test!', description: 'test', call_to_action: 'yay!'}      
      expect(Campaign.count).to eq(0)
      print("\nNon-Admin couldn't create a campaign")
    end

    it "attempts to create a campaign with no user" do
      sign_out @user
      post :create, campaign: { title: 'test', description: 'test', call_to_action: 'yay!' }
      expect(Campaign.count).to eq(0)
      print("\nAnon couldn't create a campaign")
    end

    it "attempts to create a campaign with Admin and check it's title" do           
      @user.update_attributes(:role => 'admin')
      @user.save!
      post :create, campaign: { title: 'test', description: 'test', call_to_action: 'yay!' }            
      campaign = Campaign.last
      expect(Campaign.count).to eq(1)
      expect(campaign.title).to eq('test')
      print("\nAdmin created a campaign")      
    end    
  end

  describe '#update' do
    before do
      @campaign = create(:campaign)    
      @campaign.save!      
    end

    it "attempts to update a campaign as non-admin" do
      put :update, id: @campaign, campaign: { title: 'Test!'}
      @campaign.reload
      expect(@campaign.title).to eq('Campaign Title')      
      print("\nNon-Admin couldn't update a campaign")
    end

    it "attempts to update a campaign with no user" do
      sign_out @user
      put :update, id: @campaign, campaign: { title: 'Test!'}
      @campaign.reload
      expect(@campaign.title).to eq('Campaign Title')         
      print("\nAnon couldn't update a campaign")
    end

    it "attempts to update a campaign with Admin and check it's title" do
      @user.update_attributes(:role => 'admin')
      @user.save!                
      put :update, id: @campaign, campaign: { title: 'Test!'}
      @campaign.reload
      expect(@campaign.title).to eq('Test!')
      print("\nAdmin updated a campaign")      
    end    
  end

  describe '#destroy' do
    it "attempts to create then destroy a new campaign as Admin" do
      @user.update_attributes(:role => 'admin')
      @user.save! 
      campaign = create(:campaign)
      expect(Campaign.count).to eq(1)
      delete :destroy, id: campaign.id
      expect(Campaign.count).to eq(0)
      print("\nAdmin deleted a campaign")
    end

    it "attempts to create then destroy a list with a non-admin user" do      
      campaign = create(:campaign)
      expect(Campaign.count).to eq(1)
      delete :destroy, id: campaign.id
      expect(Campaign.count).to eq(1)
      print("\nNon-Admin couldn't delete a campaign")
    end

    it "attempts to create then destroy a list without a user" do
      sign_out @user
      campaign = create(:campaign)
      expect(Campaign.count).to eq(1)
      delete :destroy, id: campaign.id
      expect(Campaign.count).to eq(1)
      print("\nAnon couldn't delete a campaign")
    end
  end

end