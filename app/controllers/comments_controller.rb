class CommentsController < ApplicationController
  
  ##
  # POST /posts/:post_id/comments
  # POST /albums/:album_id/comments
  # POST /photos/:photo_id/comments
  def create
    # params[:comment][:name]
    # params[:comment][:body]
    # ...
    @comment = Comment.new(params[:comment])
    
    if @comment.save
      flash[:notice] = "Your comment was saved"
    else
      ##
      # Mogli bi smo ovde imati malo deskriptivniji opis koristeci
      # @comment.errors.on(:some_field)
      flash[:notice] = "Sorry, there was an error while saving your comment"
    end
    redirect_to(polymorphic_path(@comment.commentable))
  end

end
