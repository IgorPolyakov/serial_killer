import * as React from 'react'
import { Link } from 'react-router-dom'
import type { TShow, TShows } from '~/types'

type TProps = {
  shows: TShows
}

const Shows = ({ shows }: TProps) => {
  const renderShow = ({ id, title, rating }: TShow) => (
    <li key={id}>
      <Link to={`/show/${id}`}>
        {title} -- {rating}
      </Link>
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
