TRUNCATE TABLE artists RESTART IDENTITY;

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO artists (name, genre) VALUES ('Queen', 'Rock');
INSERT INTO artists (name, genre) VALUES ('Michael Jackson', 'Pop');