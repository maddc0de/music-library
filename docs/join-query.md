# Use the database `music_library` for the following exercises and challenge.

## 1. exercise one

Use a `JOIN` query to select the `id` and `title` of all the albums from Taylor Swift. You should get the following result set:

```bash
 id |  title   
----+----------
  6 | Lover
  7 | Folklore
```

**solution:**

```bash
SELECT albums.id, albums.title
FROM albums
JOIN artists
ON artists.id = albums.artist_id
WHERE artists.name = 'Taylor Swift';
```

## 2. exercise two

Use a `JOIN` query to find the `id` and `title` of the (only) album from Pixies released in 1988. You should get the following result set:

```bash
 id |    title    
----+-------------
  2 | Surfer Rosa
```

**solution:**

```bash
SELECT albums.id, albums.title
FROM albums
JOIN artists
ON artists.id = albums.artist_id
WHERE artists.name = 'Pixies'
AND albums.release_year = 1988;
```

## 3. challenge

Find the `id` and `title` of all albums from Nina Simone released after 1975. You should get the following result set:

```bash
 album_id |       title        
----------+--------------------
        9 | Baltimore
       11 | Fodder on My Wings
```

**solution:**

```bash
SELECT albums.id, albums.title
FROM albums
JOIN artists
ON artists.id = albums.artist_id
WHERE artists.name = 'Nina Simone'
AND albums.release_year > 1975;
```