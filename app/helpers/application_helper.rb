# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def to_new(*args)
    to_action('new',args)
  end
  
  def to_edit(*args)
    to_action('edit',args)
  end
  
  def to_action(action = nil,*args)
    variant = 'path'
    i = -1
    if action
      prefix = "#{action}_"
    else
      prefix = ''
    end
    call = "#{prefix}#{args.map {|obj| obj.class.name.downcase}.join('_')}_#{variant}(#{args.map { |x| i+=1; %Q(arg[#{i}])}.join(', ')})"
    eval(call)
  end
  
  def page_title
    title = @page_title ? "=> #{@page_title}" : ''
    %(<title>peaces_of :me #{title}</title>)
  end
  
  def meta(name, content)
    %(<meta name="#{name}" content="#{content}" />)
  end
  
  def meta_description
    if @photo and !@photo.new_record?
      unless @photo.title.blank?
        "photo: #{@photo.title} from Milenko Cajkovi&#107's album: #{@photo.album.title}"
      else
        "a photo from Milenko Cajkovi&#107's album: #{@photo.album.title}"
      end
    elsif @album and !@album.new_record?
      "Milenko Cajkovi&#107's album: #{@album.title}"
    elsif @post and !@post.new_record?
      "blog post: #{@post.title} by Milenko Cajkovi&#107"
    else
      "a Milenko Cajkovi&#107's page"
    end
  end
  
  def meta_keywords
    if @photo and !@photo.new_record?
      key_words = [@photo.album.title, @photo.photo_updated_at, "Milenko Cajkovic"]
      key_words << @photo.title unless @photo.title.blank?
      key_words << @photo.album.location unless @photo.album.location.blank?
      key_words.join(', ')
    elsif @album and !@album.new_record?
      key_words = [@album.title, "Milenko Cajkovic"]
      key_words << @album.location unless @album.location.blank?
      key_words.join(', ')
    elsif @post and !@post.new_record?
      [@post.title, @post.created_at, @post.updated_at, "Milenko Cajkovi&#107"].join(',')
    else
      %w(blog photo album Milenko/ Cajkovic).join(', ')
    end
  end
  
  def logged_in?
    session[:user_id]
  end
end
