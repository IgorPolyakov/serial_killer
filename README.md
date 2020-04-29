# IMDB visualize TV Show rating

Small simple web app based on modern front-end, elixir API and IMDB dataset.

Idea based on this pic)

![](https://i.pinimg.com/originals/94/e9/59/94e9594246e51e8f6190a7dbdb38dec3.png)

## Back-end

### Routes AKA example

`http://localhost:4000/visualize?show_id=tt7767422` rating each episode

`http://localhost:4000/hinter?query=SuperNatural` hiter for search tv show

### Prepare

Make sure that you have elixir on your laptop.)

Get dependencies
```sh
$ mix do deps.get, deps.compile, compile
```

### Run
```sh
mix run --no-halt
```

### Get last IMDB dataset

Instruction is [here](https://gist.github.com/evbogdanov/9b0b11e73458e7e8d646cf7598840f1e)

## Front-end

coming soon

## License
[MIT](https://github.com/IgorPolyakov/imdb/blob/master/LICENSE)
