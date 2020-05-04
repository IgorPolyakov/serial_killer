CREATE TABLE shows (
  id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  start_year INTEGER NOT NULL
);

CREATE TABLE episodes (
  id TEXT PRIMARY KEY,
  show_id TEXT NOT NULL,
  season_number INTEGER NOT NULL,
  episode_number INTEGER NOT NULL,
  rating DECIMAL NOT NULL,
  num_votes INTEGER NOT NULL,

  FOREIGN KEY (show_id) REFERENCES shows (id)
);
