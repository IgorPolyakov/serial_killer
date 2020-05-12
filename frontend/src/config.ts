// TODO: if config starts growing, we'll make it more robust

const prod = {
  apiBaseUrl: 'https://api.serial-killer.org',
}

const dev = {
  apiBaseUrl: 'http://localhost:4000',
}

export default process.env.NODE_ENV === 'production' ? prod : dev
