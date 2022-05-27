require_relative 'lib/wiki_scraper'
require_relative 'lib/info_box_scraper'
require 'faraday'
require 'nokogiri'
require 'pry-byebug'

puts 'url?'
url = gets.chomp

wiki = WikiScraper.new(url: url)
wiki.characters_index_url
infos = InfoBoxScraper.new(wiki.information_container_doc)
infos.scrape_information_box
puts infos.informations
