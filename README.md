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
http://localhost:4000/visualizer?show_id=tt7767422
```

Find **popular** TV series by **first letters** in the title:
```
http://localhost:4000/hinter?letters=Sou%20Par
```

Find **all** TV series by **full words** in the title:
```
http://localhost:4000/searcher?words=South%20Park
```

Get the most popular shows:
```
http://localhost:4000/popular
```

Get the top rated shows:
```
http://localhost:4000/best
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

## Front-end

coming soon

## License
[MIT](https://github.com/IgorPolyakov/serial_killer/blob/master/LICENSE)
