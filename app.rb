require_relative 'lib/database_connection'
require_relative 'lib/artist_repository'
require_relative 'lib/album_repository'

class Application

  # The Application class initializer takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the AlbumRepository object (or a double of it)
  #  * the ArtistRepository object (or a double of it)
  def initialize(database_name, io = Kernel, album_repository, artist_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @album_repository = album_repository
    @artist_repository = artist_repository
  end

  def run
    # "Runs" the terminal application so it can ask the user to enter some input and then decide to run the appropriate action or behaviour.

    @io.puts "Welcome to the music library manager!\n\n"

    @io.puts "What would you like to do?\n1 - List all albums\n2 - List all artists\n\nEnter your choice:"

    user_input = @io.gets.chomp

    case user_input
      when '1'
        @io.puts "Here is the list of albums:"
        @album_repository.all.each do |record|
          @io.puts "* #{record.id} - #{record.title}"
        end
      when '2'
        @io.puts "Here is the list of artists:"
        @artist_repository.all.each do |record|
          @io.puts "* #{record.id} - #{record.name}"
        end
      else
        "please input 1 or 2 only"
    end
  end
end

# saying "only run the following code if this is the main file being run, instead of having been required or loaded by another file" 
# to learn more about __FILE__ and $0: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
if __FILE__ == $0
  app = Application.new(
    'music_library',
    Kernel,
    AlbumRepository.new,
    ArtistRepository.new
  )
  app.run
end