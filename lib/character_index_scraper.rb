# frozen_string_literal: true

require_relative 'wiki_scraper'

# Scraper to be used into character index page to retrive all chars from specific book
class CharacterIndexScraper
  attr_reader :urls

  def initialize(attributes = {})
    @base_url = attributes[:base_url]
    @html_doc = attributes[:doc] || get_doc
    @urls = []
    all_urls
  end

  def all_urls
    @html_doc.search('.article-table').empty? ? scrape_from_lists : scrape_from_tables
    self
  end

  def only_urls
    @urls.map { _1[:url] }
  end

  def push_data_to_urls(nokogiri_a_tag)
    if nokogiri_a_tag.attr('href')
      return if nokogiri_a_tag.text.match? /index/

      @urls << { data: nokogiri_a_tag.attr('title'), url: nokogiri_a_tag.attr('href') }
    else
      push_text(nokogiri_a_tag)
    end
    self
  end

  def push_text(a_tag)
    @urls << { data: a_tag.text }
    self
  end

  def scrape_from_lists
    @html_doc.search('.mw-headline').each do |span|
      span.parent.next_element.search('li > a').each do |link|
        push_data_to_urls(link)
      end
    end
    self
  end

  def scrape_from_tables
    @html_doc.search('.article-table').each do |table|
      table.search('tr').each do |element|
        a_tag = element.first_element_child.children
        push_data_to_urls(a_tag.first)
      end
    end
    self
  end

  private

  def get_doc
    @html_doc = WikiScraper.new(url: @base_url).build_nokogiri_doc_from_url
  end
end
