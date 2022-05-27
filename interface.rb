require_relative 'lib/wiki_scraper'
require_relative 'lib/book_scraper'
require_relative 'lib/info_box_scraper'
require_relative 'lib/character_index_scraper'
require 'faraday'
require 'nokogiri'
require 'pry-byebug'

puts 'Scraping all characters urls'

base_url = 'https://harrypotter.fandom.com'
path = '/wiki/Harry_Potter_(book_series)'
wiki = WikiScraper.new(url: "#{base_url}#{path}")
doc = wiki.build_nokogiri_doc_from_url
book_scraper = BookScraper.new doc: doc
book_scraper.books_urls
book_scraper.urls.each do |book_hash|
  book_doc = WikiScraper.new(url: "#{base_url}#{book_hash[:url]}").build_nokogiri_doc_from_url
  index_url = BookScraper.new(doc: book_doc).characters_index_url
#  p index_url
  index_doc = WikiScraper.new(url: "#{base_url}#{index_url}").build_nokogiri_doc_from_url
  all_urls = CharacterIndexScraper.new(doc: index_doc).urls
  # p all_urls
end
