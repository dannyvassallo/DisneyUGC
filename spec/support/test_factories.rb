module TestFactories
  
  def associated_post(options={})
    post_options = {
        title: 'Post title',
        body: 'Post bodies must be pretty long.',
        campaign: Campaign.create(name: 'Campaign name'),
        user: authenticated_user
      }.merge(options)

      Post.create(post_options)
  end

  def non_admin_user(options={})
    user_options = {email: "email#{rand}@fake.com", password: 'password'}.merge(options)
    user = User.new(user_options)    
    user.save
    user
  end

  def admin_user(options={})
    user_options = {email: "email#{rand}@fake.com", password: 'password', role: 'admin'}.merge(options)
    user = User.new(user_options)    
    user.save
    user
  end
end