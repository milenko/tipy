class SitemapModel
  def pages
    @photos = Photo.find_for_sitemap
    @albums = Album.find_for_sitemap
    @posts = Post.find_for_sitemap
    (@posts + @albums + @photos).sort { |a,b| b.updated_at <=> a.updated_at }
  end
end