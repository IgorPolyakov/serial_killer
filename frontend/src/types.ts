// DECIMAL(3, 1) converted to a string
type TRating = string

export interface TShow {
  id: string
  title: string
  start_year: number
  rating: TRating
  num_votes: number
}

export type TShows = Array<TShow>

interface TEpisode {
  id: string
  season_number: number
  episode_number: number
  rating: TRating
  num_votes: number
}

export type TEpisodes = Array<TEpisode>

export interface TShowWithEpisodes {
  show: TShow
  episodes: TEpisodes
}
