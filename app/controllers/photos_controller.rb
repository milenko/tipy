class PhotosController < ApplicationController
  before_filter :get_album
  
  # GET /album/:album_id/photos
  # GET /album/:album_id/photos.xml
  def index
    @photos = @album.photos

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @photos }
    end
  end

  # GET /album/:album_id/photos/:id
  # GET /photos/:photo_id.xml
  def show
    # @photo = Photo.find_by_album_id_and_id(params[:album_id],
    #                                            params[:id],
    #                                            :include => :album)
    @photo = @album.photos.find(params[:id])
  
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @photo }
    end
  end
  
  # GET /albums/:album_id/photos/new
  # GET /albums/:album_id/photos/new.xml
  def new
    @photo = Photo.new
  
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @photo }
    end
  end
  
  # GET /albums/:album_id/photos/:id/edit
  def edit
    # @photo = Photo.find_by_album_id_and_id(params[:album_id],
    #                                           params[:id],
    #                                           :include => :album)
    @photo = @album.photos.find(params[:id])
  end
  
  # POST /photos
  # POST /photos.xml
  def create
    @photo = Photo.new(params[:photo])
    @photo.album_id = params[:album_id]
  
    respond_to do |format|
      if @album.photos << @photo
        flash[:notice] = 'Photo was successfully created.'
        format.html { redirect_to([@album,@photo]) }
        format.xml  { render :xml => @photo, :status => :created, :location => @photo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /albums/:album_id/photos/:id
  # PUT /albums/:album_id/photos/:id.xml
  def update
    @photo = @album.photos.find(params[:id])
  
    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        flash[:notice] = 'Photo was successfully updated.'
        format.html { redirect_to([@album,@photo]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /albums/:album_id/photos/:id
  # DELETE /albums/:album_id/photos/:id.xml
  def destroy
    @photo = @album.photos.find(params[:id])
    @photo.destroy
  
    respond_to do |format|
      format.html { redirect_to(photos_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def get_album
    @album = Album.find(params[:album_id])
  end
  
end
