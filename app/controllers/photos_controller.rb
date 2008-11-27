class PhotosController < ApplicationController
  before_filter :get_album, :except => [:index, :show]
  before_filter :check_authentication, :except => [:index, :show]
  
  # GET /album/:album_id/photos
  # GET /album/:album_id/photos.xml
  # GET /photos
  def index
    if params[:album_id].nil?
      @photos = Photo.find_descending
      action = "all_index"
    else
      get_album
      @photos = @album.photos
      action = "index"
    end

    respond_to do |format|
      format.html { render :action => action }# index.html.erb
      format.xml  { render :xml => @photos }
    end
  end

  # GET /album/:album_id/photos/:id
  # GET /album/:album_id/photos/:id.xml
  # GET /photos/:id
  def show
    ##
    # photos/:id -> albums/:album_id/photos/:id
    if params[:album_id].nil?
      photo = Photo.find(params[:id])
      redirect_to album_photo_path(photo.album_id,photo.id) and return
    end
    
    get_album  
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
    #@photo.album_id = params[:album_id]
  
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
    ##
    # Note that we would normaly use:
    # @photo = @album.photos.new(params[:photo])
    # but we need album_id initialized before photo
    @photo = Photo.new(:album_id => params[:album_id])
    @photo.attributes = params[:photo]
  
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
    if params[:album_id].nil?
      render :text => "No such action"
      return false
    else
      @album = Album.find(params[:album_id])
    end
  end
  
end
