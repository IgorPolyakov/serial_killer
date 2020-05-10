import * as React from 'react'
import * as ReactDOM from 'react-dom'
import 'mobx-react-lite/batchingForReactDom'

import Hello from './components/Hello'
import TestMobx from './components/TestMobx'

ReactDOM.render(
  <div>
    <Hello to="Serial Killer" />
    <TestMobx />
  </div>,
  document.getElementById('serial-killer')
)
