# Serial Killer

Visualize ratings of your favourite TV series!

## About

Small simple web app based on modern front-end, Elixir API and IMDB dataset.

Idea based on this pic)

![](https://i.pinimg.com/originals/94/e9/59/94e9594246e51e8f6190a7dbdb38dec3.png)

## Back-end

### API

Get ratings for each episode:
```
/visualizer?show_id=tt7767422
```

Find **popular** TV series by **first letters** in the title:
```
/hinter?letters=Sou%20Par
```

Find **all** TV series by **full words** in the title:
```
/searcher?words=South%20Park
```

Get the most popular shows:
```
/popular
```

Get the top rated shows:
```
/best
```

### Prepare

Make sure that you have Docker and Elixir on your machine.

Then setup environment:
```sh
./setup-development-environment.sh
```

Get dependencies
```sh
cd kekend
mix do deps.get, deps.compile, compile
```

### Run

With interactive shell:
```sh
iex -S mix
```

Without:

```sh
mix run --no-halt
```

## Front end

### Build

```sh
cd frontend
yarn
```

### Start front-end server

```sh
yarn start
```

### Code formatting

We use [Prettier](https://prettier.io/) to format our code.

Show the list of unformatted files:

```sh
yarn run prettier
```

## License
[MIT](https://github.com/IgorPolyakov/serial_killer/blob/master/LICENSE)
