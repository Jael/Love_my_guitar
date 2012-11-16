class Comment < ActiveRecord::Base
  attr_accessible :content, :parent_id, :user_id
  
  validates_presence_of :content
  belongs_to :post
  belongs_to :user
  has_ancestry
end
