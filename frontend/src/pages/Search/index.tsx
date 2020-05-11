import * as React from 'react'
import useQueryParams from '~hooks/useQueryParams'
import { searchShows } from '~/api'
import Shows from './components/Shows'

const Search = () => {
  const queryParams = useQueryParams()
  const words = queryParams.get('words')

  const [isSearching, setIsSearching] = React.useState(false)
  const [shows, setShows] = React.useState([])

  React.useEffect(() => {
    if (!words) return

    const callApi = async () => {
      setIsSearching(true)
      const foundShows = await searchShows(words)
      setIsSearching(false)
      setShows(foundShows)
    }

    callApi()
  }, [words]) // Only re-run the effect if words change

  if (isSearching) return <p>Searching...</p>

  const heading = words ? `Search: ${words}` : 'Empty search'

  return (
    <>
      <h1>{heading}</h1>
      <Shows shows={shows} />
    </>
  )
}

export default Search
