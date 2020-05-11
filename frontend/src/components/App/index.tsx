import * as React from 'react'
import { BrowserRouter as Router, Switch, Route } from 'react-router-dom'
import Header from '~components/Header'
import Home from '~/pages/Home'
import Search from '~/pages/Search'
import Show from '~/pages/Show'
import NotFound from '~/pages/NotFound'
import { GlobalStyle } from './styled'

const App = () => (
  <>
    <GlobalStyle />
    <Router>
      <Header />
      <Switch>
        <Route exact path="/">
          <Home />
        </Route>
        <Route exact path="/search">
          <Search />
        </Route>
        <Route exact path="/show/:id">
          <Show />
        </Route>
        <Route path="*">
          <NotFound />
        </Route>
      </Switch>
    </Router>
  </>
)

export default App
