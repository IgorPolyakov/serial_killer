#!/usr/bin/env ruby

tmp_dir = File.join(File.dirname(__FILE__), '../tmp/')

$file_with_normalized_shows = File.join(tmp_dir, 'normalized-shows.tsv')
$file_with_raw_episodes = File.join(tmp_dir, 'episodes.tsv')
$file_with_normalized_episodes = File.join(tmp_dir, 'normalized-episodes.tsv')

$shows = {}

File.readlines($file_with_normalized_shows).each do |line|
  show_id = line.split(/\t/)[0]
  $shows[show_id] = true
end

File.open($file_with_normalized_episodes, "w+") do |file|
  File.readlines($file_with_raw_episodes).each do |line|
    id, show_id, season_number, episode_number = line.strip.split(/\t/)

    next unless $shows.has_key?(show_id)

    season_number = 0 if season_number == '\N'
    episode_number = 0 if episode_number == '\N'

    file.puts("#{id}\t#{show_id}\t#{season_number}\t#{episode_number}")
  end
end
