require_relative './artist'

class ArtistRepository
  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:  SELECT id, name, genre FROM artists;
    # Returns an array of Artist objects.

    sql = 'SELECT id, name, genre FROM artists;'  # SELECT query
    # call DatabaseConnection to run/execute SELECT query
    result_set = DatabaseConnection.exec_params(sql, [])
    # resilt_set is an array of hashes
    
    artists = []

    # array of artist instances
    result_set.each do |record| #key is column
      artist = Artist.new
      artist.id = record['id']
      artist.name = record['name']
      artist.genre = record['genre']

      artists << artist
    end

    artists
  end

end
