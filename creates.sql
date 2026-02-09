-- creates.sql

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