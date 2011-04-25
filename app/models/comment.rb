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
  
  def display_name
    if !name.blank?
      name
    elsif !email.blank?
      email
    else
      "Anonymous"
    end
  end
  
  def display_blog_name
    if !blog_name.blank?
      blog_name
    elsif !blog_url.blank?
      blog_url
    else
      nil
    end
  end
end
