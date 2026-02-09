-- ДОПОЛНЕНИЕ ДАННЫХ (если ещё не сделано) 

-- Альбом 2019 года
INSERT INTO Album (title, release_year) VALUES ('Live in Paris', 2019);
INSERT INTO ArtistAlbum (artist_id, album_id) VALUES (1, 5);
INSERT INTO Track (title, duration, album_id) VALUES ('Somebody to Love (Live)', 280, 5);

-- ЗАПРОСЫ ЗАДАНИЯ 3 

-- 1. Количество исполнителей в каждом жанре
SELECT g.name AS genre, COUNT(ag.artist_id) AS artist_count
FROM Genre g
LEFT JOIN ArtistGenre ag ON g.id = ag.genre_id
GROUP BY g.id, g.name
ORDER BY artist_count DESC;

-- 2. Количество треков в альбомах 2019–2020
SELECT COUNT(t.id) AS track_count
FROM Track t
JOIN Album a ON t.album_id = a.id
WHERE a.release_year BETWEEN 2019 AND 2020;

-- 3. Средняя продолжительность треков по каждому альбому
SELECT a.title AS album, ROUND(AVG(t.duration), 2) AS avg_duration_seconds
FROM Album a
JOIN Track t ON a.id = t.album_id
GROUP BY a.id, a.title
ORDER BY avg_duration_seconds DESC;

-- 4. Исполнители без альбомов в 2020
SELECT ar.name
FROM Artist ar
LEFT JOIN ArtistAlbum aa ON ar.id = aa.artist_id
LEFT JOIN Album al ON aa.album_id = al.id AND al.release_year = 2020
WHERE al.id IS NULL;

-- 5. Сборники с Dua Lipa
SELECT DISTINCT c.title
FROM Collection c
JOIN CollectionTrack ct ON c.id = ct.collection_id
JOIN Track t ON ct.track_id = t.id
JOIN Album a ON t.album_id = a.id
JOIN ArtistAlbum aa ON a.id = aa.album_id
JOIN Artist ar ON aa.artist_id = ar.id
WHERE ar.name = 'Dua Lipa';