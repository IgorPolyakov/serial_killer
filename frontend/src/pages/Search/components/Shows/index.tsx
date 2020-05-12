import * as React from 'react'
import { Link } from 'react-router-dom'

// TODO: add Show types
const Shows = ({ shows }) => {
  const renderShow = ({ id, title }) => (
    <li key={id}>
      <Link to={`/show/${id}`}>{title}</Link>
    </li>
  )

  return (
    <>
      <p>Found shows: {shows.length}</p>
      <ul>{shows.map(renderShow)}</ul>
    </>
  )
}

export default Shows
