-- selects.sql

-- ЗАДАНИЕ 2

-- 1. Самый длительный трек
SELECT title, duration FROM Track ORDER BY duration DESC LIMIT 1;

-- 2. Треки >= 3.5 мин
SELECT title FROM Track WHERE duration >= 210;

-- 3. Сборники 2018–2020
SELECT title FROM Collection WHERE release_year BETWEEN 2018 AND 2020;

-- 4. Исполнители с именем из одного слова
SELECT name FROM Artist WHERE name NOT LIKE '% %';

-- 5. Треки, содержащие слово "my" как отдельное слово
SELECT title
FROM Track
WHERE title ILIKE 'my'
   OR title ILIKE 'my %'
   OR title ILIKE '% my'
   OR title ILIKE '% my %';

-- ЗАДАНИЕ 3 

-- 1. Количество исполнителей в каждом жанре
SELECT g.name AS genre, COUNT(ag.artist_id) AS artist_count
FROM Genre g
LEFT JOIN ArtistGenre ag ON g.id = ag.genre_id
GROUP BY g.id, g.name
ORDER BY artist_count DESC;

-- 2. Треки в альбомах 2019–2020
SELECT COUNT(t.id) AS track_count
FROM Track t
JOIN Album a ON t.album_id = a.id
WHERE a.release_year BETWEEN 2019 AND 2020;

-- 3. Средняя продолжительность по альбомам
SELECT a.title AS album, ROUND(AVG(t.duration), 2) AS avg_duration_seconds
FROM Album a
JOIN Track t ON a.id = t.album_id
GROUP BY a.id, a.title
ORDER BY avg_duration_seconds DESC;

-- 4. Исполнители, которые НЕ выпустили альбомы в 2020 году
SELECT name
FROM Artist
WHERE id NOT IN (
    SELECT DISTINCT ar.id
    FROM Artist ar
    JOIN ArtistAlbum aa ON ar.id = aa.artist_id
    JOIN Album al ON aa.album_id = al.id
    WHERE al.release_year = 2020
);

-- 5. Сборники с Dua Lipa
SELECT DISTINCT c.title
FROM Collection c
JOIN CollectionTrack ct ON c.id = ct.collection_id
JOIN Track t ON ct.track_id = t.id
JOIN Album a ON t.album_id = a.id
JOIN ArtistAlbum aa ON a.id = aa.album_id
JOIN Artist ar ON aa.artist_id = ar.id
WHERE ar.name = 'Dua Lipa';


-- ЗАДАНИЕ 4 (необязательное)

-- 1. Альбомы с исполнителями более чем одного жанра
SELECT DISTINCT a.title
FROM Album a
JOIN ArtistAlbum aa ON a.id = aa.album_id
JOIN Artist ar ON aa.artist_id = ar.id
WHERE ar.id IN (
    SELECT artist_id
    FROM ArtistGenre
    GROUP BY artist_id
    HAVING COUNT(genre_id) > 1
);

-- 2. Треки, не входящие в сборники
SELECT t.title
FROM Track t
LEFT JOIN CollectionTrack ct ON t.id = ct.track_id
WHERE ct.track_id IS NULL;

-- 3. Исполнители самого короткого трека
SELECT ar.name
FROM Artist ar
JOIN ArtistAlbum aa ON ar.id = aa.artist_id
JOIN Track t ON aa.album_id = t.album_id
WHERE t.duration = (SELECT MIN(duration) FROM Track);

-- 4. Альбомы с наименьшим числом треков
WITH track_counts AS (
    SELECT a.id, a.title, COUNT(t.id) AS track_count
    FROM Album a
    LEFT JOIN Track t ON a.id = t.album_id
    GROUP BY a.id, a.title
)
SELECT title
FROM track_counts
WHERE track_count = (SELECT MIN(track_count) FROM track_counts);