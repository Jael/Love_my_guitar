require 'email_format_validator.rb'
class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :auth_token
  validates :password, presence: true, length: 6..20, on: :create
  validates :email, presence: true, uniqueness: true, email_format: true 
  validates_presence_of :name
  has_many :evaluations, class_name: "ReputationSystem::Evaluation", as: :source
  has_many :posts
  has_many :comments
  before_create { generate_token(:auth_token)}
  has_reputation :votes, source: {reputation: :votes, of: :posts}, aggregated_by: :sum
  has_secure_password

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def voted_for?(post)
    evaluations.where(target_type: post.class, target_id: post).present?
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver 
  end
  
end
