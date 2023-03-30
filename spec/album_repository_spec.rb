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
    expect(albums.length).to eq(2)
    expect(albums[0].id).to eq(1)
    expect(albums[0].title).to eq('The Game')
    expect(albums[0].release_year).to eq(1980) 
    expect(albums[0].artist_id).to eq(1)

  end

  it "returns The Game album" do
    repo = AlbumRepository.new
    album = repo.find(1)

    expect(album.id).to eq(1)
    expect(album.title).to eq('The Game')
    expect(album.release_year).to eq(1980) 
    expect(album.artist_id).to eq(1)

  end

  it "returns The Works album" do
    repo = AlbumRepository.new
    album = repo.find(2)
  
    expect(album.title).to eq('The Works')
    expect(album.release_year).to eq(1984) 
    expect(album.artist_id).to eq(1)

  end

  it 'creates a new album' do
    repo = AlbumRepository.new

    new_album = Album.new
    new_album.title = 'A Night at the Opera'
    new_album.release_year = 1975
    new_album.artist_id = 1

    repo.create(new_album)

    all_albums = repo.all
    expect(all_albums.length).to eq(3)
    expect(all_albums.last.title).to eq('A Night at the Opera')
    expect(all_albums.last.release_year).to eq(1975)
    expect(all_albums.last.artist_id).to eq(1)

    # expect(all_albums).to include(
    #   have_attributes(
    #     title: new_album.title,
    #     release_year: 1975,
    #     artist_id: 1
    #   )
    # )
  end

  it "deletes an album" do
    repo = AlbumRepository.new

    id_to_delete = 1

    repo.delete(id_to_delete)

    all_albums = repo.all
    expect(all_albums.length).to eq(1)
  end

  it "deletes two albums" do
    repo = AlbumRepository.new

    repo.delete(1)
    repo.delete(2)

    all_albums = repo.all
    expect(all_albums.length).to eq(0)
  end

end
