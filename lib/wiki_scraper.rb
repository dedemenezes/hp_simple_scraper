require 'faraday'
require 'nokogiri'
require 'pry-byebug'

class WikiScraper
  attr_reader :html_doc, :information_container_doc

  def initialize(attributes = {})
    @url = attributes[:url]
    @file_path = attributes[:file_path]
    build_nokogiri_doc_from_url if @url
    build_nokogiri_doc_from_file if @file_path
    # filter_information_container_doc
  end

  def build_nokogiri_doc_from_url
    html_file = Faraday.get(@url).body
    @html_doc = Nokogiri::HTML(html_file)
  end

  def build_nokogiri_doc_from_file
    html_file = File.open(@file_path).read
    # binding.pry
    @html_doc = Nokogiri::HTML(html_file)
  end

  def filter_information_container_doc
    @information_container_doc = @html_doc.search('aside.portable-infobox.pi-background.pi-border-color')
  end
end
