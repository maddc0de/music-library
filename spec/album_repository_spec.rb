require_relative '../lib/album_repository'

RSpec.describe AlbumRepository do

  def reset_albums_table
    seed_sql = File.read('spec/seeds_albums.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do
    reset_albums_table
  end

  it "returns list of albums" do
    repo = AlbumRepository.new

    albums = repo.all
    expect(albums.length).to eq(2) # =>  2
    expect(albums[0].id).to eq('1') # =>  1 
    expect(albums[0].title).to eq('The Game')
    expect(albums[0].release_year).to eq('1980') 
    expect(albums[0].artist_id).to eq('1')

  end

  it "returns The Game album" do
    repo = AlbumRepository.new
    album = repo.find(1)
  
    expect(album.title).to eq('The Game')
    expect(album.release_year).to eq('1980') 
    expect(album.artist_id).to eq('1')

  end

  it "returns The Works album" do
    repo = AlbumRepository.new
    album = repo.find(2)
  
    expect(album.title).to eq('The Works')
    expect(album.release_year).to eq('1984') 
    expect(album.artist_id).to eq('1')

  end
end
