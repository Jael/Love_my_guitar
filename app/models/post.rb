class Post < ActiveRecord::Base
  attr_accessible :title, :url
  validates_presence_of :title, :url
  has_many :comments
end
