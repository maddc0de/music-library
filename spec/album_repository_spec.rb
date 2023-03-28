require 'album_repository'

RSpec.describe AlbumRepository do



  it "returns list of albums" do
    repo = AlbumRepository.new

    albums = repo.all
    expect(albums.length).to eq(2) # =>  2
    expect(albums[0].id).to eq(1) # =>  1 
    expect(albums[0].title).to eq('The Game')
    expect(albums[0].release_year).to eq('1980') 
    expect(albums[0].artist_id).to eq('1')

  end
end
