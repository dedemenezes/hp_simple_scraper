require_relative '../book_scraper.rb'

RSpec.describe BookScraper do
  let(:book) = BookScraper.new File.open('../hp_one.html').read
end
