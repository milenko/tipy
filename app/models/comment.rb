class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  
  def name
    if super.empty?
      nil
    else
      super
    end
  end
  
end
