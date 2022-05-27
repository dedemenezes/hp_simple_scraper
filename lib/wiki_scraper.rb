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
  end

  def build_nokogiri_doc_from_url
    html_file = Faraday.get(@url).body
    @html_doc = Nokogiri::HTML(html_file)
  end

  def build_nokogiri_doc_from_file
    html_file = File.open(@file_path).read
    @html_doc = Nokogiri::HTML(html_file)
  end
end
