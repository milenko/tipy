class AllPhotosController < ApplicationController
  # GET /photos
  # GET /photos.xml
  def index
    #debugger
    @photos = Photo.find_descending

    respond_to do |format|
      format.html #{ render index.html.erb }
      format.xml  { render :xml => @photos }
    end
  end
  
  def show
    photo = Photo.find(params[:id])
    redirect_to album_photo_path(photo.album_id,photo.id)
  end
end
