class BookScraper
  attr_reader :urls

  def initialize(attributes = {})
    @doc = attributes[:doc]
    @url = attributes[:url]
  end

  def books_urls
    @urls = []
    @doc.search('ol > li > i > a').each do |a_tag|
      @urls << { data: a_tag.attr('title'), url: a_tag.attr('href') }
    end
    @urls
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
