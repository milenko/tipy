class Photo < ActiveRecord::Base
  has_attachment :storage => :file_system,
                 :resize_to => '800x600',
                 :thumbnails => {:thumb => '160x120', :tiny => '50>' }, 
                 :max_size => 5.megabytes, 
                 :content_type => :image, 
                 :processor => 'Rmagick'
                 
  validates_as_attachment
  
  belongs_to :album
  has_many :comments, :as => :commentable

  def self.find_descending
    find(:all, :order => "created_at DESC", :conditions => "thumbnail IS NULL" )
  end

  def has_comments?
    comments.size > 0
  end
  
end
