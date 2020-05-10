import * as React from 'react'
import { useLocalStore, useObserver } from 'mobx-react-lite'

const TestMobx = () => {
  const store = useLocalStore(() => ({
    count: 0,
    incr() {
      store.count += 1
    },
    decr() {
      store.count -= 1
    },
  }))

  return useObserver(() => (
    <div>
      <p>Counter {store.count}</p>
      <span onClick={store.incr}>+</span>
      {` | `}
      <span onClick={store.decr}>-</span>
    </div>
  ))
}

export default TestMobx
