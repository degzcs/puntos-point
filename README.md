## App

Compose created to work with rails 3 and ruby 1.9.3

### Dependencies

- docker
- docker-compose

You can check how to install them [here](https://docs.docker.com/compose/install/)

### Installation & Setup

After you install docker and clone this repo, you have open a terminal and go to the project folder.
Then run the next commands:

```bash
$ docker-compose build
$ docker-compose up
```

These commands are going to install all packages and dependencies need it for the project.

Finally, go to `http:127.0.0.1:3100`

### Dev

Useful command in dev env:

```bash
$ docker exec -it  puntos-point_app_1 bundle exec rails c
$ docker exec -it  puntos-point_app_1 zsh
```

```zsh
export GIT_SSH_COMMAND="ssh -i ~/.ssh/diego_example"
gp origin main
```

### API requests examples

#### Granularity Report

```zsh
$ curl http://localhost:3000/api/purchases/granularity_report?granularity=day  -X GET -H 'Authorization: Bearer this-is-the-jwt'
```

### Tests

```bash
$ docker exec -it  puntos-point_app_1 bundle exec rspec spec
```
