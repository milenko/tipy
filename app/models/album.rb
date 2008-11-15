class Album < ActiveRecord::Base
  has_many :photos
  has_many :comments, :as => :commentable
  
  def has_comments?
    comments.size > 0
  end
end
