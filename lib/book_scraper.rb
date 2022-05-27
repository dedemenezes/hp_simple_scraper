class BookScraper
  def initialize(attributes = {})
    @doc = attributes[:doc]
    @url = attributes[:url]
    
  end

  def characters_index_url
    index_url = ''
    ul = @doc.search('span#See_also.mw-headline').first.parent.next.next
    ul.search('a').each do |li|
      index_url = li.attr('href') if li.attr('title').match? /index/
    end
    index_url
  end
end
