class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  
  named_scope :not_empty, :conditions => "body != '' and body is not null"
  #named_scope :empty, :conditions => "body = '' or body is null"
  
  def name
    if super.empty?
      nil
    else
      super
    end
  end
  
end
