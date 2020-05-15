import * as React from 'react'
import { useParams } from 'react-router-dom'
import { getShowWithEpisodes } from '~/api'
import type { TShow, TEpisodes } from '~/types'

const Show = () => {
  const { id: showId } = useParams()

  const [isFetching, setIsFetching] = React.useState(true)
  const [show, setShow] = React.useState<TShow>(null)
  const [episodes, setEpisodes] = React.useState<TEpisodes>([])

  React.useEffect(() => {
    const callApi = async () => {
      const {
        show: fetchedShow,
        episodes: fetchedEpisodes,
      } = await getShowWithEpisodes(showId)
      setIsFetching(false)
      setShow(fetchedShow)
      setEpisodes(fetchedEpisodes)
    }

    callApi()
  }, [showId]) // Only re-run the effect if show id changes

  if (isFetching) return <p>Fetching...</p>

  if (!show) return <p>Show not found</p>

  return (
    <>
      <h1>{show.title}</h1>
      <p>Rating: {show.rating}</p>
      <p>Start year: {show.start_year}</p>
      <p>Votes: {show.num_votes}</p>
      <p>Episodes: {episodes.length}</p>
    </>
  )
}

export default Show
