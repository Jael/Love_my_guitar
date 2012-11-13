class Post < ActiveRecord::Base
  attr_accessible :title, :url, :tag_list 
  validates_presence_of :title
  validates_presence_of :url 
  has_many :comments
  belongs_to :type
  belongs_to :user
  has_reputation :votes, source: :user, aggregated_by: :sum
  acts_as_taggable
  
end
