import * as React from 'react'
import { useParams } from 'react-router-dom'
import { getShowWithEpisodes } from '~/api'

const Show = () => {
  const { id: showId } = useParams()

  const [isFetching, setIsFetching] = React.useState(true)
  const [show, setShow] = React.useState(null)
  const [episodes, setEpisodes] = React.useState([])

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
      <p>Episodes: {episodes.length}</p>
    </>
  )
}

export default Show
