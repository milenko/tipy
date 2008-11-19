class Post < ActiveRecord::Base
  validates_presence_of :title
  
  has_many :comments, :as => :commentable
  
  named_scope :recent,
              lambda { |*args| 
                {:order => "updated_at DESC",
                 :conditions => ["updated_at > ?",
                                 (args.first || 2.weeks.ago).to_s(:db)]
                }
              }
  named_scope :latest, 
              lambda {|*args|
                {:order => "updated_at DESC",
                 :limit => (args.first || 2)
                }
              }
  
  ##
  # Sve funkcionalnosti vezane sa modelom, treba staviti u model
  # cak i ovako relativno jednostavne
  def self.find_descending
    find(:all, :order => "updated_at DESC")
  end
  
  ##
  # Rails 2.0 ne pravi automatski ove funkcije, tako da moramo sami
  def has_comments?
    comments.size > 0
  end
  
end