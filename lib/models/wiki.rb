class Wiki
  attr_reader :data, :url
  def initialize(attributes = {})
    @data = attributes[:data]
    @url = attributes[:url]
  end
end
