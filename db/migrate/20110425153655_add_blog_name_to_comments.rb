class AddBlogNameToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :blog_name, :string
  end

  def self.down
    remove_column :comments, :blog_name
  end
end
