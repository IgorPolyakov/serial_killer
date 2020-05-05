#!/usr/bin/env bash

################################################################################
### Set up Postgres
################################################################################

docker rm -f serial-killer-postgres
docker run -d --name serial-killer-postgres -p 5432:5432 -e POSTGRES_PASSWORD=postgres postgres:12
sleep 2
echo 'CREATE DATABASE serial_killer' | docker exec -i serial-killer-postgres psql -U postgres
cat ./sql/2020-04-30-create-tables.sql | docker exec -i serial-killer-postgres psql -U postgres serial_killer


################################################################################
### Download IMDb data files
################################################################################

rm -rf tmp/
mkdir -p tmp/

# TODO: download files concurrently
echo 'Downloading IMDb files...'
curl https://datasets.imdbws.com/title.basics.tsv.gz --output ./tmp/all-films.tsv.gz
curl https://datasets.imdbws.com/title.episode.tsv.gz --output ./tmp/episodes.tsv.gz
curl https://datasets.imdbws.com/title.ratings.tsv.gz --output ./tmp/ratings.tsv.gz

gunzip ./tmp/all-films.tsv.gz
gunzip ./tmp/episodes.tsv.gz
gunzip ./tmp/ratings.tsv.gz


################################################################################
### Normalize data
################################################################################

# Filter only shows (no porn) and extract their id, title, start_year
echo 'Normalizing shows...'
awk -F'\t' '($2 == "tvSeries" || $2 == "tvMiniSeries") && $5 == 0 { print $1"\t"$3"\t"$6 }' ./tmp/all-films.tsv | sed 's/\\N$/0/' > ./tmp/normalized-shows.tsv

echo 'Normalizing episodes...'
./scripts/normalize-episodes.rb


################################################################################
### Insert normalized data to Postgres
################################################################################

echo 'Inserting into Postgres...'
cat ./tmp/normalized-shows.tsv | docker exec -i serial-killer-postgres psql -U postgres serial_killer -c "COPY shows FROM STDIN DELIMITER E'\t'"
cat ./tmp/normalized-episodes.tsv | docker exec -i serial-killer-postgres psql -U postgres serial_killer -c "COPY episodes FROM STDIN DELIMITER E'\t'"
