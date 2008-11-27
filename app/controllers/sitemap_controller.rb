class SitemapController < ApplicationController
  ##
  # sitemap, ocekuje da dobije pages array, i jedino sto ocekuje od njega je da
  # njegovi elemenit odgovaraju na updated_at i da budu resursi, da bi moglo da
  # se pozove url_for(pages[i]).
  # Ovime smo prebacili odgovornost za sastavljanje sadrzaja sitemap-a u model
  # gde i pripada, a ovaj kontroler je 100% genericki i nece morati da se
  # menja.
  
  def sitemap
    @pages = SitemapModel.new.pages
    headers['Last-Modified'] = @pages.first.updated_at.httpdate if @pages.first
    render :layout => false
  end
end
