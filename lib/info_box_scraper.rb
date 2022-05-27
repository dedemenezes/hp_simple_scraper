require_relative 'info_box_parser'

class InfoBoxScraper
  attr_reader :informations

  def initialize(doc)
    @doc = doc
    @informations = {}
  end

  def scrape_information_box
    @doc.search('[data-source]').each do |information|
      values = []
      parser = InfoBoxParser.new(information)
      if parser.information_list.empty?
        values << parser.build_information_hash
      else
        list_items = parser.information_list.search('li')
        list_items.each do |element|
          item_parser = InfoBoxParser.new(element)
          values << item_parser.build_information_hash
        end
      end

      information_name = information.attr('data-source')
      @informations[information_name] = values
    end
    informations
  end
end
