class Artist
  #  attributes are table columns.
  attr_accessor :id, :name, :genre, :albums

  def initialize
    @albums = []
  end
end