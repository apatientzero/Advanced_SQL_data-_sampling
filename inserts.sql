-- inserts.sql

-- Исполнители
INSERT INTO Artist (name) VALUES
('Queen'),
('Dua Lipa'),
('Kendrick Lamar'),
('Adele');

-- Жанры
INSERT INTO Genre (name) VALUES
('Рок'),
('Поп'),
('Хип-хоп'),
('Поп-рок');  -- добавлено для задания 4

-- Альбомы
INSERT INTO Album (title, release_year) VALUES
('A Night at the Opera', 1975),
('Future Nostalgia', 2020),
('To Pimp a Butterfly', 2015),
('30', 2021),
('Live in Paris', 2019);

-- Треки
INSERT INTO Track (title, duration, album_id) VALUES
('Bohemian Rhapsody', 354, 1),
('Don''t Stop Me Now', 210, 1),
('Levitating', 203, 2),
('Physical', 194, 2),
('Alright', 218, 3),
('King Kunta', 234, 3),
('My Love', 198, 4),
('Somebody to Love (Live)', 280, 5),
('Hidden Track', 120, 1);  -- не в сборниках

-- Сборники
INSERT INTO Collection (title, release_year) VALUES
('Greatest Hits Vol. 1', 2019),
('Pop Party 2025', 2025),
('Rap Essentials', 2024),
('Classic Rock Anthology', 2020);

-- Связь: Исполнитель — Жанр
INSERT INTO ArtistGenre (artist_id, genre_id) VALUES
(1, 1), -- Queen → Рок
(1, 4), -- Queen → Поп-рок (для задания 4)
(2, 2), -- Dua Lipa → Поп
(3, 3), -- Kendrick Lamar → Хип-хоп
(4, 2); -- Adele → Поп

-- Связь: Исполнитель — Альбом
INSERT INTO ArtistAlbum (artist_id, album_id) VALUES
(1, 1),
(1, 5),
(2, 2),
(3, 3),
(4, 4);

-- Связь: Сборник — Трек
INSERT INTO CollectionTrack (collection_id, track_id) VALUES
(1, 1),
(1, 7),
(2, 3),
(2, 4),
(3, 5),
(3, 6),
(4, 1),
(4, 2);
-- Обратите внимание: track_id=8 и 9 (Hidden Track) НЕ добавлены → они вне сборников