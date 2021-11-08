# README

```
$ cp .env.sample .env
$ docker-compose build --no-cache
$ docker-compose run --rm app rails db:create
$ docker-compose run --rm app rails db:migrate
$ docker-compose up

$ open http://localhost:3000
```