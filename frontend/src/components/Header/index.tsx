import * as React from 'react'
import { Link } from 'react-router-dom'
import { StyledHeader } from './styled'

const Header = () => (
  <StyledHeader>
    <Link to="/">Home page</Link>
  </StyledHeader>
)

export default Header
