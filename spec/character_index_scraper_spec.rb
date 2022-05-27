require_relative '../lib/character_index_scraper'

RSpec.describe CharacterIndexScraper do
  describe '#all_urls' do
    context 'when organizard in tables' do
      doc = WikiScraper.new(file_path: 'data/char_index_one.html').build_nokogiri_doc_from_file
      chars = %w[/wiki/Norberta /wiki/Charlie_Weasley%27s_colleagues /wiki/Ronan /wiki/Bane /wiki/Firenze /wiki/Unicorn]
      chars.each do |character_url|
        let(:char) { CharacterIndexScraper.new doc: doc }
        name = character_url[6..].gsub('_', ' ')
        it "must include url for #{name}" do
          actual = char.all_urls
          expect(actual.only_urls).to include(character_url)
        end
      end
    end

    context 'when organized in lists' do
      doc = WikiScraper.new(file_path: 'data/char_index_seven_lists.html').build_nokogiri_doc_from_file
      char = CharacterIndexScraper.new doc: doc
      actual = char.all_urls

      chars = %w[/wiki/Albino_peacock /wiki/Percival_Dumbledore /wiki/Selwyn]
      chars.each do |character_url|
        name = character_url[6..].gsub('_', ' ')
        it "must include url for #{name}" do
          expect(actual.only_urls).to include(character_url)
        end
      end
    end
  end
end
