require 'faker'

1.times do 
  @campaign = Campaign.new(
    title: 'radio disney contest',
    description: Faker::Lorem.paragraph(2),
    call_to_action: Faker::Lorem.sentence,
    feature: File.open(Dir['app/assets/images/faker/*.jpg'].sample)
  )
  @campaign.update_attributes!(created_at: rand(10.minutes .. 1.year).ago)
  @campaign.save!
end
campaigns = Campaign.all

100.times do
  post = Post.new(
      full_name: Faker::Name.name,
      email_address: Faker::Internet.email,
      dob: Faker::Date.backward(900000),
      image_url: File.open(Dir['app/assets/images/faker/*.jpg'].sample),
      campaign_id: @campaign.id
    )
    post.update_attributes!(created_at: rand(10.minutes .. 1.year).ago)
    post.save!
end
posts = Post.all  

puts "#{campaigns.count} Campaign(s) created"
puts "#{posts.count} Post(s) created"