class Comment < ActiveRecord::Base
  attr_accessible :content, :parent_id
  belongs_to :post
  has_ancestry
end
