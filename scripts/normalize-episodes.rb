#!/usr/bin/env ruby
# frozen_string_literal: true

tmp_dir = File.join(File.dirname(__FILE__), '../tmp/')

file_with_normalized_shows = File.join(tmp_dir, 'normalized-shows.tsv')
file_with_raw_episodes = File.join(tmp_dir, 'episodes.tsv')
file_with_normalized_episodes = File.join(tmp_dir, 'normalized-episodes.tsv')
file_with_ratings = File.join(tmp_dir, 'ratings.tsv')

shows = {}

File.readlines(file_with_normalized_shows).each do |line|
  show_id = line.split(/\t/)[0]
  shows[show_id] = true
end

ratings = File.read(file_with_ratings).split("\n").map do |raw_rating|
  raw_rating = raw_rating.split(/\t/)
  [
    raw_rating[0], [raw_rating[1], raw_rating[2]]
  ]
end.to_h

File.open(file_with_normalized_episodes, 'w+') do |file|
  File.readlines(file_with_raw_episodes).each do |line|
    id, show_id, season_number, episode_number = line.strip.split(/\t/)
    next unless shows.key?(show_id)

    rating, num_votes = ratings[id]

    season_number = 0 if season_number == '\N'
    episode_number = 0 if episode_number == '\N'
    num_votes ||= 0
    rating ||= 0
    file.puts("#{id}\t#{show_id}\t#{season_number}\t#{episode_number}\t#{rating}\t#{num_votes}")
  end
end
