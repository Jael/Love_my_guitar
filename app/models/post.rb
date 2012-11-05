class Post < ActiveRecord::Base
  attr_accessible :title, :url, :tag, :type_id, :text
  validates_presence_of :title, :url
  has_many :comments
  belongs_to :type
end
