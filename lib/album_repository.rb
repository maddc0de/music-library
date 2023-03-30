require_relative './album'

class AlbumRepository
  def all
    # Executes the SQL query:
    # SELECT id, title, release_year, artist_id FROM albums;
    # Returns an array of Album objects.

    sql = 'SELECT id, title, release_year, artist_id FROM albums;'
    result = DatabaseConnection.exec_params(sql, [])

    albums = []
    result.each do |record| #key is column
      album = Album.new
      album.id = record['id'].to_i
      album.title = record['title']
      album.release_year = record['release_year'].to_i
      album.artist_id = record['artist_id'].to_i

      albums << album
    end

    albums
  end

  def find(id)
    sql = 'SELECT id, title, release_year, artist_id FROM albums WHERE id = $1;'
    sql_params = [id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)
    record = result_set[0]

    album = Album.new
    album.id = record['id'].to_i
    album.title = record['title']
    album.release_year = record['release_year'].to_i
    album.artist_id = record['artist_id'].to_i

    album
  end

  def create(album)
    sql = 'INSERT INTO albums (title, release_year, artist_id) VALUES ($1, $2, $3);'
    sql_params = [album.title, album.release_year, album.artist_id]

    DatabaseConnection.exec_params(sql, sql_params)

    nil
  end

  def delete(id)
    sql = 'DELETE FROM albums WHERE id = $1;'
    sql_params = [id]

    DatabaseConnection.exec_params(sql, sql_params)

    nil
  end

  


  

end