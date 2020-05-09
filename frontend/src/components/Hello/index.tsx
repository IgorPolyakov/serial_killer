import * as React from 'react'

interface Props {
  to: string
}

const Hello: React.FC<Props> = ({ to }) => <h1>Hello, {to}!</h1>

export default Hello
