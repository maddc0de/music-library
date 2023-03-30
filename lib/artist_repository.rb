require_relative './artist'

class ArtistRepository
  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:  SELECT id, name, genre FROM artists;
    # Returns an array of Artist objects.

    sql = 'SELECT id, name, genre FROM artists;'  # SELECT query
    # call DatabaseConnection to run/execute SELECT query
    result_set = DatabaseConnection.exec_params(sql, [])   # result_set is an array of hashes
    
    artists = [] # array of artist instances

    
    result_set.each do |record| #key is column
      artist = Artist.new
      artist.id = record['id']
      artist.name = record['name']
      artist.genre = record['genre']

      artists << artist
    end

    artists
  end

  def find(id)
    sql = 'SELECT id, name, genre FROM artists WHERE id = $1;'
    sql_params = [id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)

    record = result_set[0]

    artist = Artist.new
    artist.id = record['id']
    artist.name = record['name']
    artist.genre = record['genre']
    
    artist
  end

  def create(artist)
    sql = 'INSERT INTO artists (name, genre) VALUES ($1, $2);'
    sql_params = [artist.name, artist.genre]

    DatabaseConnection.exec_params(sql, sql_params)

    nil
  end

  def delete(id)
    sql = 'DELETE FROM artists WHERE id = $1;'
    sql_params = [id]

    DatabaseConnection.exec_params(sql, sql_params)

    nil
  end

  def update(artist)
    sql = 'UPDATE artists SET name = $1, genre = $2 WHERE id = $3;'
    sql_params = [artist.name, artist.genre, artist.id]

    DatabaseConnection.exec_params(sql, sql_params)

    nil
  end



end
