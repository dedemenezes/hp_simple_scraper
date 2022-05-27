require_relative '../lib/wiki_scraper'
require_relative '../lib/book_scraper'

RSpec.describe BookScraper do

  describe '#characters_index_url' do
    doc = WikiScraper.new(file_path: 'hp_one.html').build_nokogiri_doc_from_file
    scraper = BookScraper.new(doc: doc)
    it 'return correct url' do
      expect(scraper.characters_index_url).to eq('/wiki/Harry_Potter_and_the_Philosopher%27s_Stone_(character_index)')
    end
  end

  describe '#books_urls' do
    doc = WikiScraper.new(file_path: 'book_series.html').build_nokogiri_doc_from_file
    scraper = BookScraper.new(doc: doc)
    it 'returns all seven books urls' do
      actual = scraper.books_urls
      expect(actual).to be_an(Array)
      urls = scraper.urls.map { _1[:url] }
      expected = [
        '/wiki/Harry_Potter_and_the_Philosopher%27s_Stone',
        '/wiki/Harry_Potter_and_the_Chamber_of_Secrets',
        '/wiki/Harry_Potter_and_the_Prisoner_of_Azkaban',
        '/wiki/Harry_Potter_and_the_Goblet_of_Fire',
        '/wiki/Harry_Potter_and_the_Order_of_the_Phoenix',
        '/wiki/Harry_Potter_and_the_Half-Blood_Prince',
        '/wiki/Harry_Potter_and_the_Deathly_Hallows'
      ]
      expect(urls).to eq(expected)
    end
  end
end
