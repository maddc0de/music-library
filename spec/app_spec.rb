require_relative '../app'
require_relative '../lib/database_connection'

describe Application do
  it "returns the list of albums when user inputs 1" do
    io = double :io
    albums = AlbumRepository.new
    artists = ArtistRepository.new
    application = Application.new('music_library_test', io, albums, artists)

    expect(io).to receive(:puts).with("Welcome to the music library manager!\n\n").ordered
    expect(io).to receive(:puts).with("What would you like to do?\n1 - List all albums\n2 - List all artists\n\nEnter your choice:").ordered
    expect(io).to receive(:gets).and_return("1").ordered

    expect(io).to receive(:puts).with("Here is the list of albums:").ordered
    expect(io).to receive(:puts).with("* 1 - The Game").ordered
    expect(io).to receive(:puts).with("* 2 - The Works").ordered

    application.run
  end

  it "returns the list of artists when user inputs 2" do
    io = double :io
    albums = AlbumRepository.new
    artists = ArtistRepository.new
    application = Application.new('music_library_test', io, albums, artists)

    expect(io).to receive(:puts).with("Welcome to the music library manager!\n\n").ordered
    expect(io).to receive(:puts).with("What would you like to do?\n1 - List all albums\n2 - List all artists\n\nEnter your choice:").ordered
    expect(io).to receive(:gets).and_return("2").ordered

    expect(io).to receive(:puts).with("Here is the list of artists:").ordered
    expect(io).to receive(:puts).with("* 1 - Queen").ordered
    expect(io).to receive(:puts).with("* 2 - Michael Jackson").ordered

    application.run
  end
end
