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
    return scrape_from_lists if @html_doc.search('.article-table').empty?

    scrape_from_tables
    self
  end

  def only_urls
    @urls.map { _1[:url] }
  end

  def push_data_to_urls(nokogiri_a_tag)
    @urls << { data: nokogiri_a_tag.attr('title'), url: nokogiri_a_tag.attr('href') }
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
        href = a_tag.attr('href')
        if href
          url = href.value
          data = a_tag.attr('title').value
          @urls << { data: data, url: url }
        else
          @urls << { data: a_tag.text }
        end
      end
    end
  end

  private

  def get_doc
    @html_doc = WikiScraper.new(url: @base_url).build_nokogiri_doc_from_url
  end
end
