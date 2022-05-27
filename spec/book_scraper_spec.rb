require_relative '../lib/wiki_scraper'
require_relative '../lib/book_scraper'

RSpec.describe BookScraper do
  describe '#characters_index_url' do
    let(:doc) { WikiScraper.new(file_path: 'hp_one.html').build_nokogiri_doc_from_file }
    it 'return correct url' do
      scraper = BookScraper.new(doc: doc)
      expect(scraper.characters_index_url).to eq('/wiki/Harry_Potter_and_the_Philosopher%27s_Stone_(character_index)')
    end
  end
end
