TRUNCATE TABLE albums RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed title

INSERT INTO albums (title, release_year, artist_id) VALUES ('The Game', '1980', '1');
INSERT INTO albums (title, release_year, artist_id) VALUES ('The Works', '1984', '1');