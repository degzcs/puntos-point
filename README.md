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
$ curl http://localhost:3000/api/purchases?start_date='2024-01-26'&&end_date='2024-01-27'&&granularity=day  -X GET -H 'Authorization: Bearer this-is-the-jwt'
```
NOTE: all the filters from Purchases can be used here.

#### Purchase filters

```zsh
$ curl http://localhost:3000/api/purchases?start_date='2024-01-26'&&end_date='2024-01-27'  -X GET -H 'Authorization: Bearer this-is-the-jwt'
$ curl http://localhost:3000/api/purchases?category_id=1  -X GET -H 'Authorization: Bearer this-is-the-jwt'
$ curl http://localhost:3000/api/purchases?customer_id=1  -X GET -H 'Authorization: Bearer this-is-the-jwt'
```

### Get JWT
```zsh
$ curl http://localhost:3000/api/sessions/login -d 'email=test@test.com&password=123123' -X POST
```

### Emails
Go to the `tmp/letter_opener` folder to check the emails. For example

```zsh
cat tmp/letter_opener/1706501071_3021488_d70cc59/plain.html
```
### Tests

```bash
$ docker exec -it  puntos-point_app_1 bundle exec rspec spec
```
