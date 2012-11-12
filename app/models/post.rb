class Post < ActiveRecord::Base
  attr_accessible :title, :url, :tag, :type_id, :text
  validates_presence_of :title
  has_many :comments
  belongs_to :type
  belongs_to :user
  has_reputation :votes, source: :user, aggregated_by: :sum
  before_create :validates_url_or_text
  

  def validates_url_or_text
    if !url.nil? || !text.nil?
      flash.now.alert = "Please input the url or text"
      render :show
    end
  end
end
