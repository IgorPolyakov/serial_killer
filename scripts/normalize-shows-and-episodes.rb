#!/usr/bin/env ruby
# frozen_string_literal: true

tmp_dir = File.join(File.dirname(__FILE__), '../tmp/')
file_with_all_raw_films = File.join(tmp_dir, 'all-films.tsv')
file_with_normalized_shows = File.join(tmp_dir, 'normalized-shows.tsv')
file_with_raw_episodes = File.join(tmp_dir, 'episodes.tsv')
file_with_normalized_episodes = File.join(tmp_dir, 'normalized-episodes.tsv')
file_with_ratings = File.join(tmp_dir, 'ratings.tsv')

ratings = File.read(file_with_ratings).split("\n").map do |line|
  id, rating, num_votes = line.split(/\t/)
  [id, [rating, num_votes]]
end.to_h

shows = {}

File.open(file_with_normalized_shows, 'w+') do |file|
  File.readlines(file_with_all_raw_films).each do |line|
    id, title_type, primary_title, _original_title, is_adult, start_year, _end_year, _runtime_minutes, _genres = line.strip.split(/\t/)
    next unless (title_type == 'tvSeries' || title_type == 'tvMiniSeries') && is_adult == '0'

    rating, num_votes = ratings[id]
    start_year = 0 if start_year == '\N'
    next unless num_votes

    shows[id] = true
    file.puts("#{id}\t#{primary_title}\t#{start_year}\t#{rating}\t#{num_votes}")
  end
end

File.open(file_with_normalized_episodes, 'w+') do |file|
  File.readlines(file_with_raw_episodes).each do |line|
    id, show_id, season_number, episode_number = line.strip.split(/\t/)
    next unless shows.key?(show_id)

    rating, num_votes = ratings[id]
    next unless num_votes

    season_number = 0 if season_number == '\N'
    episode_number = 0 if episode_number == '\N'
    num_votes ||= 0
    rating ||= 0
    file.puts("#{id}\t#{show_id}\t#{season_number}\t#{episode_number}\t#{rating}\t#{num_votes}")
  end
end
