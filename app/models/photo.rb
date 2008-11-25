class Photo < ActiveRecord::Base
  @@PolaroidFont = '-font aaaiight! -pointsize 16 -gravity center '
  @@PolaroidColors = '-bordercolor white -background black '
  
  
  belongs_to :album
  has_many :comments, :as => :commentable
  
  has_attached_file :photo,
                    :styles => {:show => ['800x600>', 'png'],
                                :thumb => ['160x120#', 'png'],
                                :tiny => ['50>', 'png'],
                                :poster => ['144x160#', 'png']},
                    :default_style => :show,
                    :convert_options => lambda { |*args| {
                      :thumb => @@PolaroidColors + "+polaroid",
                      :poster => @@PolaroidFont + @@PolaroidColors +
                        "-set caption \"#{args.first ? args.first.caption : "album" }\" -polaroid 0"
                    }}
                    
  acts_as_list :scope => :album
                                
  validates_attachment_presence :photo
  #validates_attachment_size :photo, :less_then => 5.megabytes
  #validates_attachment_content_type :photo, :content_type => {'image/jpeg', 'image/png'}
  
  named_scope :recent,
              lambda { |*args| 
                {:order => "photo_updated_at DESC",
                 :limit => (args.first || 6)
                }
              }
  
  def self.find_descending
    find(:all, :order => "created_at DESC")
  end

  def has_comments?
    comments.size > 0
  end
  
  def caption
    album.title
  end
  
end
