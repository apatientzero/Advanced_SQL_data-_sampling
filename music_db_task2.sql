-- 1. СОЗДАНИЕ ТАБЛИЦ

CREATE TABLE IF NOT EXISTS Artist (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Genre (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Album (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    release_year INTEGER NOT NULL CHECK (release_year >= 1900 AND release_year <= 2026)
);

CREATE TABLE IF NOT EXISTS Track (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    duration INTEGER NOT NULL CHECK (duration > 0),
    album_id INTEGER NOT NULL REFERENCES Album(id)
);

CREATE TABLE IF NOT EXISTS Collection (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    release_year INTEGER NOT NULL CHECK (release_year >= 1900 AND release_year <= 2026)
);

CREATE TABLE IF NOT EXISTS ArtistGenre (
    artist_id INTEGER REFERENCES Artist(id),
    genre_id INTEGER REFERENCES Genre(id),
    PRIMARY KEY (artist_id, genre_id)
);

CREATE TABLE IF NOT EXISTS ArtistAlbum (
    artist_id INTEGER REFERENCES Artist(id),
    album_id INTEGER REFERENCES Album(id),
    PRIMARY KEY (artist_id, album_id)
);

CREATE TABLE IF NOT EXISTS CollectionTrack (
    collection_id INTEGER REFERENCES Collection(id),
    track_id INTEGER REFERENCES Track(id),
    PRIMARY KEY (collection_id, track_id)
);


-- 2. ВСТАВКА ДАННЫХ 

-- Исполнители
INSERT INTO Artist (name) VALUES
('Queen'),               -- одно слово ✅
('Dua Lipa'),
('Kendrick Lamar'),
('Adele');               -- одно слово ✅ (для надёжности)

-- Жанры
INSERT INTO Genre (name) VALUES
('Рок'),
('Поп'),
('Хип-хоп');

-- Альбомы
INSERT INTO Album (title, release_year) VALUES
('A Night at the Opera', 1975),
('Future Nostalgia', 2020),
('To Pimp a Butterfly', 2015),
('30', 2021);            -- альбом Adele

-- Треки
INSERT INTO Track (title, duration, album_id) VALUES
('Bohemian Rhapsody', 354, 1),   -- 5:54 — самый длинный
('Don''t Stop Me Now', 210, 1), -- ровно 3:30
('Levitating', 203, 2),
('Physical', 194, 2),
('Alright', 218, 3),             -- 3:38
('King Kunta', 234, 3),
('My Love', 198, 4);             -- содержит "My" ✅

-- Сборники
INSERT INTO Collection (title, release_year) VALUES
('Greatest Hits Vol. 1', 2019),  -- ← в диапазоне 2018–2020 ✅
('Pop Party 2025', 2025),
('Rap Essentials', 2024),
('Classic Rock Anthology', 2020); -- ← тоже в диапазоне ✅

-- Связь: Исполнитель — Жанр
INSERT INTO ArtistGenre (artist_id, genre_id) VALUES
(1, 1), -- Queen → Рок
(2, 2), -- Dua Lipa → Поп
(3, 3), -- Kendrick Lamar → Хип-хоп
(4, 2); -- Adele → Поп

-- Связь: Исполнитель — Альбом
INSERT INTO ArtistAlbum (artist_id, album_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);

-- Связь: Сборник — Трек
INSERT INTO CollectionTrack (collection_id, track_id) VALUES
(1, 1), -- Greatest Hits → Bohemian Rhapsody
(1, 7), -- Greatest Hits → My Love
(2, 3),
(2, 4),
(3, 5),
(3, 6),
(4, 1),
(4, 2);


-- 3. ЗАПРОСЫ (задание 2)

-- 1. Название и продолжительность самого длительного трека.
SELECT title, duration
FROM Track
ORDER BY duration DESC
LIMIT 1;

-- 2. Название треков, продолжительность которых не менее 3,5 минут (≥210 сек).
SELECT title
FROM Track
WHERE duration >= 210;

-- 3. Названия сборников, вышедших в период с 2018 по 2020 год включительно.
SELECT title
FROM Collection
WHERE release_year BETWEEN 2018 AND 2020;

-- 4. Исполнители, чьё имя состоит из одного слова.
SELECT name
FROM Artist
WHERE name NOT LIKE '% %';

-- 5. Название треков, которые содержат слово «my» (регистронезависимо).
SELECT title
FROM Track
WHERE LOWER(title) LIKE '%my%';