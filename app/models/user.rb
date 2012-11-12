require 'email_format_validator.rb'
class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :auth_token
  has_secure_password
  validates :password, presence: true, length: 6..20, on: :create
  validates_presence_of :name
  validates :email, presence: true, uniqueness: true, email_format: true 
  has_many :posts
  before_create { generate_token(:auth_token)}
  has_reputation :votes, source: {reputation: :votes, of: :posts}, aggregated_by: :sum
  has_many :evaluations, class_name: "ReputationSystem::Evaluation", as: :source

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def voted_for?(post)
    evaluations.where(target_type: post.class, target_id: post.id).present?
  end
end
