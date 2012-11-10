class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password
  validates_presence_of :password
  validates_presence_of :name
  validates :email, presence: true, uniqueness: true
  has_many :posts

  has_reputation :votes, source: {reputation: :votes, of: :posts}, aggregated_by: :sum
  has_many :evaluations, class_name: "ReputationSystem::Evaluation", as: :source

  def voted_for?(post)
    evaluations.where(target_type: post.class, target_id: post.id).present?
  end
end
