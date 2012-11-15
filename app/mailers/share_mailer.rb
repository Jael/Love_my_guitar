class ShareMailer < ActionMailer::Base
  default from: "Love_my_guitar@finger.com"

  def share_email(post, email, name, message)
    @post = post
    @url = post_url(@post, host: 'localhost:3000')
    @name = name
    @email = email
    @message = message
    mail to: email, subject: "There is the sharing from Love_my_guitar website"
  end

end
