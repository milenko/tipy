class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  
  named_scope :not_empty, :conditions => "body != '' and body is not null"
  
  def name
    if super.empty?
      nil
    else
      super
    end
  end
  
end
