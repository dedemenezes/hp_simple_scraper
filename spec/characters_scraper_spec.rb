require_relative '../lib/character_scraper'

RSpec.describe 'CharacterScraper' do
  describe '#url' do
    let(:doc) { WikiScraper.new(file_path: 'hp_one.html').build_nokogiri_doc_from_file }
    chars = %w[/wiki/Vernon_Dursley /wiki/Cornelius_Fudge /wiki/Norberta /wiki/Charlie_Weasley%27s_colleagues /wiki/Ronan /wiki/Bane /wiki/Firenze /wiki/Unicorn]
    chars.each do |character_url|
      let(:char) { CharacterScraper.new doc }
      name = character_url[6..].gsub('_', ' ')
      it "returns correct url for #{name}" do
        actual = char.url
        expect(actual).to eq(character_url)
      end

    end
  end
end
