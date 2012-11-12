class Comment < ActiveRecord::Base
  attr_accessible :content, :parent_id
  validates_presence_of :content
  belongs_to :post
  has_ancestry
end
