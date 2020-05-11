import config from '~/config'

export const searchShows = (words: string) => {
  const encodedWords = encodeURIComponent(words)

  console.log(
    `Going to search: ${config.apiBaseUrl}/search?words=${encodedWords}`
  )
}

export const getShowWithEpisodes = (showId: string) => {
  console.log(`Get show: ${config.apiBaseUrl}/visualizer?show_id=${showId}`)
}
