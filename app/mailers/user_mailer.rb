class UserMailer < ActionMailer::Base
  default from: "noreply@#{ENV['EMAIL_']}"

  def notification_email(post)
    @post = post
    mail(:to => @post.campaign.email_recipients,
         :subject => "#{@post.email_address} Submitted An Entry!")
  end

end