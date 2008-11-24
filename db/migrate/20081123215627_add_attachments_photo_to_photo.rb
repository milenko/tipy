class AddAttachmentsPhotoToPhoto < ActiveRecord::Migration
  def self.up
    add_column :photos, :photo_file_name, :string
    add_column :photos, :photo_content_type, :string
    add_column :photos, :photo_file_size, :integer
    add_column :photos, :photo_updated_at, :datetime
    
    ##
    # Romove attachmetn_fu columns
    remove_column :photos, :content_type
    remove_column :photos, :filename
    remove_column :photos, :path
    remove_column :photos, :parent_id
    remove_column :photos, :thumbnail
    remove_column :photos, :size
    remove_column :photos, :width
    remove_column :photos, :height
  end

  def self.down
    remove_column :photos, :photo_file_name
    remove_column :photos, :photo_content_type
    remove_column :photos, :photo_file_size
    remove_column :photos, :photo_updated_at
    
    ##
    # Add back attachment_fu columns
    add_column :photos, :content_type
    add_column :photos, :filename
    add_column :photos, :path
    add_column :photos, :parent_id
    add_column :photos, :thumbnail
    add_column :photos, :size
    add_column :photos, :width
    add_column :photos, :height
  end
end
