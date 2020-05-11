import config from '~/config'
import axios from 'axios'

// TODO: add types
const makeApiCall = async ({ url, params = {}, defaultReturn = null }) => {
  try {
    const response = await axios.get(url, {
      params,
      baseURL: config.apiBaseUrl,
    })
    return response.data
  } catch (error) {
    console.error(error)
    return defaultReturn
  }
}

export const searchShows = async (words: string) =>
  await makeApiCall({
    url: '/searcher',
    params: { words },
    defaultReturn: [],
  })

export const getShowWithEpisodes = async (showId: string) =>
  await makeApiCall({
    url: '/visualizer',
    params: { show_id: showId },
    defaultReturn: {
      show: null,
      episodes: [],
    },
  })
