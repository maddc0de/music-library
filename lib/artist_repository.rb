require_relative './artist'
require_relative './album'

class ArtistRepository
  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:  SELECT id, name, genre FROM artists;
    # Returns an array of Artist objects.
    sql = 'SELECT id, name, genre FROM artists;'
    # call DatabaseConnection to run/execute SELECT query
    result_set = DatabaseConnection.exec_params(sql, [])   # result_set is an array of hashes
    
    artists = [] # array of artist instances

    result_set.each do |record| #key is column
      artist = artist_builder(record)
      artists << artist
    end

    return artists
  end

  def find(id)
    sql = 'SELECT id, name, genre FROM artists WHERE id = $1;'
    params = [id]

    result = DatabaseConnection.exec_params(sql, params)
    record = result[0]
    artist = artist_builder(record)
    
    return artist
  end

  def create(artist)
    sql = 'INSERT INTO artists (name, genre) VALUES ($1, $2);'
    params = [artist.name, artist.genre]

    DatabaseConnection.exec_params(sql, params)

    nil
  end

  def delete(id)
    sql = 'DELETE FROM artists WHERE id = $1;'
    params = [id]

    DatabaseConnection.exec_params(sql, params)

    nil
  end

  def update(artist)
    sql = 'UPDATE artists SET name = $1, genre = $2 WHERE id = $3;'
    params = [artist.name, artist.genre, artist.id]

    DatabaseConnection.exec_params(sql, params)

    nil
  end

  def find_with_albums(id)
    sql = 'SELECT artists.id,
                  artists.name,
                  artists.genre,
                  albums.id AS album_id,
                  albums.title,
                  albums.release_year
          FROM artists
          JOIN albums ON albums.artist_id = artists.id
          WHERE artists.id = $1'
    
    result_set = DatabaseConnection.exec_params(sql, [id])

    artist = artist_builder(result_set.first)

    result_set.each do |record|
      
      album = Album.new
      album.id = record['album_id']
      album.title = record['title']
      album.release_year = record['release_year']

      artist.albums << album
    end
    return artist
  end

  def artist_builder(record)
    artist = Artist.new
    artist.id = record['id']
    artist.name = record['name']
    artist.genre = record['genre']

    return artist
  end

end
