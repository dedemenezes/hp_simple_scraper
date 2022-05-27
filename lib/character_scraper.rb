require_relative 'wiki_scraper'

class CharacterScraper
  def initialize(attributes = {})
    @base_url = attributes[:base_url]
    get_doc if @base_url
    @html_doc = attributes[:doc]
  end

  def url

  end

  private

  def get_doc
    @html_doc = WikiScraper.new(url: @base_url).build_nokogiri_doc_from_url
  end
end
