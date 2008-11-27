xml.instruct! 
xml.urlset :xmlns => 'http://www.sitemaps.org/schemas/sitemap/0.9' do 
  @pages.each do |page| 
    xml.url do 
      xml.loc url_for(page) 
      xml.lastmod page.updated_at.xmlschema 
    end 
  end 
end