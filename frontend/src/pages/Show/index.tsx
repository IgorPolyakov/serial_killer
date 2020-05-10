import * as React from 'react'
import { useParams } from 'react-router-dom'

const Show = () => {
  const { id } = useParams()
  return <p>Show with id: {id}</p>
}

export default Show
