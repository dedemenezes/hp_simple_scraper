require 'faraday'
require 'nokogiri'

class InfoBoxScraper
  attr_reader :informations

  def initialize(url)
    @url = url
    @informations = {}
  end

  def scrape_information_box
    build_nokogiri_doc_from_url
    filter_information_container_doc

    @information_container_doc.search('[data-source]').each do |information|
      values = []
      values_list = information_value(information).search('ul')
      if values_list.empty?
        values << build_information_hash(information)
      else
        list_items = values_list.search('li')
        list_items.each do |element|
          values << build_information_hash(element)
        end
      end

      information_name = information.attr('data-source')
      @informations[information_name] = values
    end
    self
  end

  def build_nokogiri_doc_from_url
    html_file = Faraday.get(@url).body
    @html_doc = Nokogiri::HTML(html_file)
  end

  def filter_information_container_doc
    @information_container_doc = @html_doc.search('aside.portable-infobox.pi-background.pi-border-color')
  end

  def build_information_hash(doc)
    data = information_content(doc)
    url = information_href(doc)
    { data: remove_unecessary_text(data), url: url }
  end

  def information_content(doc)
    return doc.text.strip if doc.name == 'li'

    item = information_value(doc).text.strip
    item = doc.text.strip if item.empty?
    item = doc.search('img').attr('data-image-name').value if item.empty?
    return item
  end

  def information_value(doc)
    doc.search('.pi-data-value')
  end

  def information_href(doc)
    href = doc.search('a').attr('href')
    href.value if href
  end

  def remove_unecessary_text(str)
    str.gsub(/(\[|\().+/, '')
  end
end
