import * as React from 'react'
import * as ReactDOM from 'react-dom'
import 'mobx-react-lite/batchingForReactDom'
import App from '~/components/App'

ReactDOM.render(<App />, document.getElementById('serial-killer'))
