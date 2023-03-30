require_relative '../lib/artist_repository'

RSpec.describe ArtistRepository do

  def reset_artists_table
    seed_sql = File.read('spec/seeds_artists.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do
    reset_artists_table
  end
  
  it 'returns the list of artists' do
    repo = ArtistRepository.new

    artists = repo.all

    expect(artists.length).to eq(2) 
    expect(artists.first.id).to eq('1')
    expect(artists.first.name).to eq('Queen')
    
  end

  it 'returns the Queen as single artist' do
    repo = ArtistRepository.new

    artist = repo.find(1)

    expect(artist.name).to eq('Queen') 
    expect(artist.genre).to eq('Rock')
    
  end

  it 'returns Michael Jackson as single artist' do
    repo = ArtistRepository.new

    artist = repo.find(2)

    expect(artist.name).to eq('Michael Jackson') 
    expect(artist.genre).to eq('Pop')
    
  end

  it 'creates a new artist' do
    repo = ArtistRepository.new

    new_artist = Artist.new
    new_artist.name = 'Beatles'
    new_artist.genre = 'Pop'

    repo.create(new_artist)

    artists = repo.all
    last_artist = artists.last

    expect(last_artist.name).to eq('Beatles')
    expect(last_artist.genre).to eq('Pop')
  end

  it 'deletes the artist with id 1' do
    repo = ArtistRepository.new

    id_to_delete = 1
    repo.delete(id_to_delete)
    
    artists = repo.all
    expect(artists.length).to eq(1)
    expect(artists.first.id).to eq('2')
  end

  it 'deletes the two artists' do
    repo = ArtistRepository.new

    repo.delete(1)
    repo.delete(2)
    
    artists = repo.all
    expect(artists.length).to eq(0)
  end

  it 'updates an existing artist with new values' do
    repo = ArtistRepository.new

    artist = repo.find(1)

    artist.name = 'different name'
    artist.genre = 'Bachata'

    repo.update(artist)

    updated_artist = repo.find(1)
    expect(updated_artist.name).to eq('different name')
    expect(updated_artist.genre).to eq('Bachata')
  end

  it 'updates the artist with a new name only' do
    repo = ArtistRepository.new

    artist = repo.find(1)

    artist.name = 'different name'

    repo.update(artist)

    updated_artist = repo.find(1)
    expect(updated_artist.name).to eq('different name')
    expect(updated_artist.genre).to eq('Rock')
  end

end