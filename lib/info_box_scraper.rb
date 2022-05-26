require 'faraday'
require 'nokogiri'

class InfoBoxScraper
  attr_reader :informations

  def initialize(url)
    @url = url
    @informations = {}
  end

  def scrape_information_box
    html_file = Faraday.get(@url).body
    html_doc = Nokogiri::HTML(html_file)
    information_container_doc = html_doc.search('aside.portable-infobox.pi-background.pi-border-color')
    information_container_doc.search('[data-source]').each do |information|
      values = []
      information_name = information.attr('data-source')

      values_list = information.search('.pi-data-value').search('ul')
      if values_list.empty?
        item = information.search('.pi-data-value').text.strip
        item = information.text.strip if item.empty?
        item = information.search('img').attr('data-image-name').value if item.empty?

        url = information.search('a').attr('href').value if information.search('a').attr('href')
        values << { data: remove_unecessary_text(item), url: url }
      else
        list_items = values_list.search('li')
        list_items.each do |element|
          item = element.text.strip
          url = element.search('a').attr('href').value if element.search('a').attr('href')
          values << { data: remove_unecessary_text(item), url: url }
        end
      end
      @informations[information_name] = values
    end
    self
  end

  def remove_unecessary_text(str)
    str.gsub(/(\[|\().+/, '')
  end
end
