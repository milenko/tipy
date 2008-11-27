class Album < ActiveRecord::Base
  has_many :photos
  has_many :comments, :as => :commentable
  
  def has_comments?
    comments.size > 0
  end
  
  def poster
    photos.first
  end
  
  def empty?
    photos.empty?
  end
  
  def self.find_for_sitemap
    find(:all, :select => 'id, updated_at',
               :order => 'updated_at DESC',
               :limit => 1000)
  end
end
