# Albums Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

table is already created in the database, so can skip this step.

```
# EXAMPLE

Table: albums

Columns:
id | title | release_year | artist_id
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
TRUNCATE TABLE artists RESTART IDENTITY;
TRUNCATE TABLE albums RESTART IDENTITY;


INSERT INTO artists (name, genre) VALUES ('Queen', 'Rock');
INSERT INTO albums (title, release_year, artist_id) VALUES ('The Game', '1980', '1');
INSERT INTO albums (title, release_year, artist_id) VALUES ('The Works', '1984', '1');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 music_library_test < seeds_albums.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: albums

# Model class
# (in lib/album.rb)
class Album
end

# Repository class
# (in lib/album_repository.rb)
class AlbumRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: albums

# Model class
# (in lib/album.rb)

class Album
  attr_accessor :id, :title, :release_year, :artist_id
end

```

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: albums

# Repository class
# (in lib/album_repository.rb)

class AlbumRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, release_year, artist_id FROM albums;

    # Returns an array of Album objects.
  end

  # selecting one record
  # one argument
  def find(id) # a number
    # Executes the SQL query:
    # SELECT title, release_year, artist_id FROM albums WHERE id = $1;

    # Returns one record
  end

  def create(album)  # album abject as an argument
    # Executes the sql query:
    # INSERT INTO albums (title, release_year, artist_id) VALUES ($1, $2, $3);

    # returns nothing (only creates the record)
  end

   def delete(id)
    # Executes the sql query:
    # DELETE FROM albums WHERE id = $1;

    # returns nothing (only deletes the record)
  end

  def update(album) # album object in argument(with updated fields)
    # Executes the sql query:
    # UPDATE albums SET title = $1, release_year = $2 artist_id = $3 WHERE id = $4;

    # returns nothing (only updates the record)
  end


end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all albums

repo = AlbumsRepository.new
albums = repo.all
albums.length # =>  2
albums[0].id # =>  1 
albums[0].title # =>  'The Game' 
albums[0].release_year # =>  '1980'  
albums[0].artist_id # => '1'
```

```ruby
# 2
# Get one album
repo = AlbumRepository.new
album = repo.find(1)

album.title # => 'The Game`
album.release_year # => '1980'
album.artist_id # => '1'

# 3
# Get another album
repo = AlbumRepository.new
album = repo.find(2)

album.title # => 'The Works`
album.release_year # => '1984'
album.artist_id # => '1'
```

```ruby
# 4
# insert a new album
repo = AlbumRepository.new

new_album = Album.new
new_album.title = 'A Night at the Opera'
new_album.release_year = '1975'
new_album.artist_id = '1'

repo.create(new_album)

all_albums = repo.all
all_albums.length #=> 3
all_albums.last.title #=> 'A Night at the Opera'
```

```ruby
# 5
# deletes an existing album
repo = AlbumRepository.new

id_to_delete = 1
repo.find(id_to_delete)

all_albums = repo.all
all_albums.length #=> 1

# 5
# deletes two existing album
repo = AlbumRepository.new

repo.find(1)
repo.find(2)

all_albums = repo.all
all_albums.length #=> 0
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname:  'albums' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._