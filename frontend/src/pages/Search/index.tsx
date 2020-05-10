import * as React from 'react'
import useQueryParams from '~hooks/useQueryParams'

const Search = () => {
  const queryParams = useQueryParams()
  const words = queryParams.get('words')
  const message = words ? `Search by words: '${words}'` : 'Nothing to search'

  return <p>{message}</p>
}

export default Search
