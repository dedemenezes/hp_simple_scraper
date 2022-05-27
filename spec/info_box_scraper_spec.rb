require_relative '../lib/info_box_scraper'

RSpec.describe InfoBoxScraper do
  let(:info_box) { InfoBoxScraper.new('https://harrypotter.fandom.com/wiki/Harry_Potter') }

  context '#informations' do
    it 'returns a Hash' do
      actual = info_box.informations
      expect(actual).to be_a(Hash)
    end
  end
end
