xml.instruct! :xml, :version => "1.0"
xml.rss :version => 2.0 do
  xml.channel do
    xml.title "peaces_of :me => Posts"
    xml.description "Milenko Cajkovic's blog posts"
    xml.link posts_url
    
    for post in @posts
      xml.item do
        xml.title post.title
        xml.description post.body
        xml.pubDate post.created_at.to_s(:rfc822)
        xml.link post_url(post)
      end
    end
  end
end