-- SQLite
SELECT * FROM playlists 
JOIN playlist_track ON playlist_track.PlaylistId =playlists.PlaylistId
JOIN tracks ON playlist_track.TrackId = tracks.TrackId
WHERE playlists.Name = "Classical"

SELECT * FROM playlists 
JOIN playlist_track USING(PlaylistId)
JOIN tracks USING(TrackId)
WHERE playlists.Name = "Classical"

SELECT * FROM playlists 
JOIN playlist_track ON playlist_track.PlaylistId =playlists.PlaylistId
JOIN tracks ON playlist_track.TrackId = tracks.TrackId
WHERE max(tracks.TrackId)


--1. Find all the artists for a given Genre

SELECT count(DISTINCT artists.Name) FROM genres
JOIN tracks ON genres.GenreId = tracks.GenreId
JOIN albums ON tracks.AlbumId = albums.AlbumId
JOIN artists ON artists.ArtistId = albums.ArtistId
WHERE genres.Name = "Rock"

--2. Find the Playlist with the most / least songs (will need a group by  and count )

SELECT COUNT(tracks.TrackId), playlists.Name
FROM playlists
JOIN playlist_track ON playlists.PlaylistId = playlist_track.PlaylistId
JOIN tracks ON playlist_track.TrackId = tracks.TrackId
GROUP BY playlists.Name
ORDER BY COUNT(tracks.trackId) DESC
LIMIT 1

SELECT COUNT(tracks.TrackId) AS songCount, playlists.Name
FROM playlists
JOIN playlist_track ON playlists.PlaylistId = playlist_track.PlaylistId
JOIN tracks ON playlist_track.TrackId = tracks.TrackId
GROUP BY playlists.Name
ORDER BY songCount
LIMIT 1

--alternatives

SELECT COUNT(*), playlist_track.PlaylistId 
FROM tracks
JOIN playlist_track ON playlist_track.TrackId = tracks.TrackId
GROUP BY playlist_track.PlaylistId

SELECT COUNT(DISTINCT playlist_track.TrackId), playlist_track.PlaylistId, playlists.Name
FROM playlist_track
JOIN playlists ON playlist_track.PlaylistId = playlists.PlaylistId
GROUP BY playlist_track.PlaylistId

--3. Find the total for a given invoice (will need a sum)
SELECT Total, InvoiceId
FROM invoices
WHERE InvoiceId = 404


--4. Find all the playlists containing a given genre

SELECT DISTINCT playlists.PlaylistId, playlists.Name 
FROM playlists
JOIN playlist_track ON playlists.PlaylistId = playlist_track.PlaylistId
JOIN tracks ON playlist_track.TrackId = tracks.TrackId
JOIN genres ON genres.GenreId = tracks.GenreId
WHERE genres.Name = "Blues"

--5. Find the biggest/smallest invoice amounts (needs group by)

SELECT MAX(Total), InvoiceId
FROM invoices

SELECT MIN(Total), InvoiceId
FROM invoices



--6. Find the artist with the most/least songs (needs group by)

--most
SELECT artists.Name, COUNT(tracks.TrackId) AS songs
FROM artists
JOIN albums ON albums.ArtistId = artists.ArtistId
JOIN tracks ON tracks.AlbumId = albums.AlbumId
GROUP BY artists.Name
ORDER BY songs DESC
LIMIT 1
--least
SELECT artists.Name, COUNT(tracks.TrackId) AS songs
FROM artists
JOIN albums ON albums.ArtistId = artists.ArtistId
JOIN tracks ON tracks.AlbumId = albums.AlbumId
GROUP BY artists.Name
ORDER BY songs 
LIMIT 1 

--OR (alterantive)
--most
SELECT COUNT(tracks.TrackId) as totaltracks, artists.Name
FROM tracks
JOIN albums ON tracks.AlbumId = albums.AlbumId
JOIN artists ON artists.ArtistId = albums.ArtistId
GROUP BY artists.Name
ORDER BY totaltracks DESC
LIMIT 1

--least
SELECT COUNT(tracks.TrackId) as totaltracks, artists.Name
FROM tracks
JOIN albums ON tracks.AlbumId = albums.AlbumId
JOIN artists ON artists.ArtistId = albums.ArtistId
GROUP BY artists.Name
ORDER BY totaltracks 
LIMIT 1
--OFFSET 1 (how amounts of results are shown on web page i.e. paging


