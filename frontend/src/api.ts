import axios from 'axios'
import config from '~/config'
import type { TShows, TShowWithEpisodes } from '~/types'

interface TApiCallArgs {
  url: string
  params?: any
  defaultReturn?: any
}

const makeApiCall = async ({
  url,
  params = {},
  defaultReturn = null,
}: TApiCallArgs) => {
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

export const searchShows = async (words: string): Promise<TShows> =>
  await makeApiCall({
    url: '/searcher',
    params: { words },
    defaultReturn: [],
  })

export const getShowWithEpisodes = async (
  showId: string
): Promise<TShowWithEpisodes> =>
  await makeApiCall({
    url: '/visualizer',
    params: { show_id: showId },
    defaultReturn: {
      show: null,
      episodes: [],
    },
  })
