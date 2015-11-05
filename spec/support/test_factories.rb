module TestFactories
  
  # def associated_post(options={})
  #   post_options = {
  #       title: 'Post title',
  #       body: 'Post bodies must be pretty long.',
  #       campaign: Campaign.create(name: 'Campaign name'),
  #       user: authenticated_user
  #     }.merge(options)

  #     Post.create(post_options)
  # end

  def dead_test_campaign(options={})
    campaign_options = {
        title: 'Live Campaign',
        description: 'This is a campaign description',
        call_to_action: 'This is a CTA'                
      }.merge(options)
      Campaign.create(campaign_options)
  end

  def live_test_campaign(options={})
    campaign_options = {
        title: 'Live Campaign',
        description: 'This is a campaign description',
        call_to_action: 'This is a CTA',
        live: true                
      }.merge(options)
      Campaign.create(campaign_options)
  end

  def test_user(options={})
    user_options = {email: "email#{rand}@fake.com", password: 'password'}.merge(options)
    user = User.new(user_options)    
    user.save
    user
  end

end