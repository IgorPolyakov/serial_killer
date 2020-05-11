import * as React from 'react'
import useQueryParams from '~hooks/useQueryParams'
import { searchShows } from '~/api'

const Search = () => {
  const queryParams = useQueryParams()
  const words = queryParams.get('words')
  const message = words ? `Search by words: '${words}'` : 'Nothing to search'
  if (words) {
    searchShows(words)
  }

  return <p>{message}</p>
}

export default Search
