import * as React from 'react'
import { useHistory } from 'react-router-dom'
import { FormWrapper } from './styled'

const Home = () => {
  const history = useHistory()
  const [words, setWords] = React.useState('')

  const handleSubmit = (event) => {
    event.preventDefault()
    history.push(`/search?words=${encodeURIComponent(words)}`)
  }

  return (
    <FormWrapper>
      <form onSubmit={handleSubmit}>
        <input
          type="text"
          value={words}
          onChange={(event) => setWords(event.target.value)}
        />
        <input type="submit" value="Search" />
      </form>
    </FormWrapper>
  )
}

export default Home
