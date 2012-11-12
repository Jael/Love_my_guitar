class Post < ActiveRecord::Base
  attr_accessible :title, :url, :tag, :type_id, :text
  validates_presence_of :title
  has_many :comments
  belongs_to :type
  belongs_to :user
  has_reputation :votes, source: :user, aggregated_by: :sum
  

end
