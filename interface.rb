require_relative 'lib/wiki_scraper'
require_relative 'lib/book_scraper'
require_relative 'lib/info_box_scraper'
require_relative 'lib/character_index_scraper'
require_relative 'lib/models/book'
require 'faraday'
require 'nokogiri'
require 'pry-byebug'

puts 'Scraping all characters urls'

# base_url = 'https://harrypotter.fandom.com'
path = '/wiki/Harry_Potter_(book_series)'
wiki = WikiScraper.new(url: path)
doc = wiki.build_nokogiri_doc_from_url
book_scraper = BookScraper.new doc: doc
book_scraper.books_urls
books = book_scraper.urls.map { |item| Book.new(item) }
books.each do |book|
  wiki.url = book.url
  wiki.build_nokogiri_doc_from_url
  box = InfoBoxScraper.new(wiki.html_doc)
  book_info = box.scrape_information_box
  book_info.each do |key, value|
    # binding.pry
    book.build(key, value)
    # binding.pry
    # p book
  end
  book_scraper.doc = wiki.html_doc
  book.index_url = book_scraper.characters_index_url
end

puts books.map(&:inspect)

