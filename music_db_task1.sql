-- 1. Исполнители
CREATE TABLE IF NOT EXISTS Artist (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- 2. Жанры
CREATE TABLE IF NOT EXISTS Genre (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- 3. Альбомы
CREATE TABLE IF NOT EXISTS Album (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    release_year INTEGER NOT NULL CHECK (release_year >= 1900 AND release_year <= 2026)
);

-- 4. Треки
CREATE TABLE IF NOT EXISTS Track (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    duration INTEGER NOT NULL CHECK (duration > 0),
    album_id INTEGER NOT NULL REFERENCES Album(id)
);

-- 5. Сборники
CREATE TABLE IF NOT EXISTS Collection (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    release_year INTEGER NOT NULL CHECK (release_year >= 1900 AND release_year <= 2026)
);

-- 6. Связь: Исполнитель — Жанр
CREATE TABLE IF NOT EXISTS ArtistGenre (
    artist_id INTEGER REFERENCES Artist(id),
    genre_id INTEGER REFERENCES Genre(id),
    PRIMARY KEY (artist_id, genre_id)
);

-- 7. Связь: Исполнитель — Альбом
CREATE TABLE IF NOT EXISTS ArtistAlbum (
    artist_id INTEGER REFERENCES Artist(id),
    album_id INTEGER REFERENCES Album(id),
    PRIMARY KEY (artist_id, album_id)
);

-- 8. Связь: Сборник — Трек
CREATE TABLE IF NOT EXISTS CollectionTrack (
    collection_id INTEGER REFERENCES Collection(id),
    track_id INTEGER REFERENCES Track(id),
    PRIMARY KEY (collection_id, track_id)
);


-- ВСТАВКА ДАННЫХ 

-- Исполнители
INSERT INTO Artist (name) VALUES
('Queen'),
('Dua Lipa'),
('Kendrick Lamar'),
('The Beatles');

-- Жанры
INSERT INTO Genre (name) VALUES
('Рок'),
('Поп'),
('Хип-хоп');

-- Альбомы
INSERT INTO Album (title, release_year) VALUES
('A Night at the Opera', 1975),
('Future Nostalgia', 2020),
('To Pimp a Butterfly', 2015);

-- Треки
INSERT INTO Track (title, duration, album_id) VALUES
('Bohemian Rhapsody', 354, 1),
('Don''t Stop Me Now', 210, 1),
('Levitating', 203, 2),
('Physical', 194, 2),
('Alright', 218, 3),
('King Kunta', 234, 3);

-- Сборники
INSERT INTO Collection (title, release_year) VALUES
('Greatest Hits Vol. 1', 2022),
('Pop Party 2025', 2025),
('Rap Essentials', 2024),
('Classic Rock Anthology', 2023);

-- Связь: Исполнитель — Жанр
INSERT INTO ArtistGenre (artist_id, genre_id) VALUES
(1, 1), -- Queen → Рок
(2, 2), -- Dua Lipa → Поп
(3, 3), -- Kendrick Lamar → Хип-хоп
(4, 1); -- The Beatles → Рок

-- Связь: Исполнитель — Альбом
INSERT INTO ArtistAlbum (artist_id, album_id) VALUES
(1, 1), -- Queen → A Night at the Opera
(2, 2), -- Dua Lipa → Future Nostalgia
(3, 3); -- Kendrick Lamar → To Pimp a Butterfly

-- Связь: Сборник — Трек
INSERT INTO CollectionTrack (collection_id, track_id) VALUES
(1, 1), -- Greatest Hits → Bohemian Rhapsody
(1, 5), -- Greatest Hits → Alright
(2, 3), -- Pop Party → Levitating
(2, 4), -- Pop Party → Physical
(3, 5), -- Rap Essentials → Alright
(3, 6), -- Rap Essentials → King Kunta
(4, 1), -- Classic Rock → Bohemian Rhapsody
(4, 2); -- Classic Rock → Don't Stop Me Now