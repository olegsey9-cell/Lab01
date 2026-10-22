- Лабораторная работа №1
-- Вариант 29
-- Создание таблиц "Пути" и "Занятость путей"

-- Таблица 1. Пути
CREATE TABLE tracks (
    depot_no INTEGER NOT NULL,
    track_no INTEGER NOT NULL,
    purpose VARCHAR(100) NOT NULL,
    track_length NUMERIC(8,2) NOT NULL,
    is_free BOOLEAN NOT NULL,
    is_electrified BOOLEAN NOT NULL,

    CONSTRAINT tracks_pkey
        PRIMARY KEY (depot_no, track_no),

    CONSTRAINT positive_track_length
        CHECK (track_length > 0)
);

-- Таблица 2. Занятость путей
CREATE TABLE track_occupancy (
    depot_no INTEGER NOT NULL,
    track_no INTEGER NOT NULL,
    arrival_time TIMESTAMP NOT NULL,
    departure_time TIMESTAMP,
    tram_no INTEGER NOT NULL,
    additional_info TEXT,

    CONSTRAINT track_occupancy_pkey
        PRIMARY KEY (
            depot_no,
            track_no,
            arrival_time
        ),

    CONSTRAINT track_occupancy_fkey
        FOREIGN KEY (depot_no, track_no)
        REFERENCES tracks(depot_no, track_no)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT valid_departure
        CHECK (
            departure_time IS NULL
            OR departure_time >= arrival_time
        )
);
