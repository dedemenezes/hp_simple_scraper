require 'nokogiri'
require 'pry-byebug'
require 'open-uri'

# file = File.open("hp_one.html").read
file = URI.open('https://harrypotter.fandom.com/wiki/Harry_Potter').read
html_doc = Nokogiri::HTML(file)
# binding.pry

# label = information.search('.pi-data-label').text.strip
# find infoblock


informations = {}

information_container_doc = html_doc.search('aside.portable-infobox.pi-background.pi-border-color')
information_container_doc.search('[data-source]').each_with_index do |information, index|
  values = []
  information_name = information.attr('data-source')
  # next if index < 2

  values_list = information.search('.pi-data-value').search('ul')
  if values_list.empty?
    item = information.search('.pi-data-value').text.strip
    item = information.text.strip if item.empty?
    item = information.search('img').attr('data-image-name').value if item.empty?
    link = information.search('a').attr('href').value if information.search('a').attr('href')
    values << { data: item, url: link }
  else
    list_items = values_list.search('li')
    list_items.each do |element|
      item = element.text.strip
      link = element.search('a').attr('href').value if element.search('a').attr('href')
      values << { data: item, url: link }
    end
  end
  informations[information_name] = values

  # links = information.search('a')
  # unless links.empty?
  # link = information.search('a').attr('href').value
  #   puts link
  # end
end

puts informations

# Identify infoblock categories
