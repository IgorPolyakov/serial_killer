# Serial Killer

Visualize ratings of your favourite TV series!

## About

Small simple web app based on modern front-end, Elixir API and IMDB dataset.

Idea based on this pic)

![](https://i.pinimg.com/originals/94/e9/59/94e9594246e51e8f6190a7dbdb38dec3.png)

## Back-end

### Routes AKA example

Get ratings for each episode:
```
http://localhost:4000/visualize?show_id=tt7767422
```

Find TV series by typing first letters:
```
http://localhost:4000/hinter?query=SuperNatural
```

### Prepare

Make sure that you have Docker and Elixir on your machine.


Then setup environment:
```
./setup-development-environment.sh
```

Get dependencies
```sh
$ mix do deps.get, deps.compile, compile
```

### Run
```sh
mix run --no-halt
```

## Front-end

coming soon

## License
[MIT](https://github.com/IgorPolyakov/serial_killer/blob/master/LICENSE)
