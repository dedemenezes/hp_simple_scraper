require_relative '../lib/models/book'

RSpec.describe Book do
  book = Book.new

  describe '#prepare_attribute_name' do
    it 'remove whitespace and add `_`' do
      actual = book.prepare_attribute_name('banner url')
      expected = 'banner_url'
      expect(actual).to eq expected
    end
  end

  describe '#build' do
    key = 'banner'
    url = 'https://banner.com'
    values = [{ data: key, url: url }]
    it 'add new instance variable' do
      book.build(key, values)
      expect { book.banner }.not_to raise_error
      expect(book.banner).to be_a(String)
      expect(book.banner).to eq(key)
    end

    it 'add new instance variable with url sufix' do
      book.build(key, values)
      expect { book.banner_url }.not_to raise_error
      expect(book.banner_url).to be_a(String)
      expect(book.banner_url).to eq(url)
    end

    it 'add new attribute reader' do
      # book.define_attribute_readers
    end
    # book.build('banner', )
    # expect(book).to respond_to(:banner)
  end
end
