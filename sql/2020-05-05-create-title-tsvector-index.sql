CREATE EXTENSION unaccent;

CREATE OR REPLACE FUNCTION title_to_tsvector(title TEXT)
  RETURNS tsvector
AS
$BODY$
  SELECT to_tsvector('simple', unaccent(title));
$BODY$
LANGUAGE sql
IMMUTABLE;

CREATE INDEX title_tsvector_index
ON shows
USING gin(title_to_tsvector(title));
