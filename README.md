# Start the Project

## Setup DataBase

`POSTGRES_USER` & `POSTGRES_PASSWORD` have to be the same in both files.

```
# .docker/.env

POSTGRES_USER: <postgres_user>
POSTGRES_PASSWORD: <postgres_password>
```

```
# .env

POSTGRES_USER: <postgres_user>
POSTGRES_PASSWORD: <postgres_password>
POSTGRES_PORT: <postgres_port>
POSTGRES_HOST: <postgres_host>
```

```
docker compose -f .docker/docker-compose.database.yml up -d
```

```
rails db:create db:migrate
```

## Import Recipes 🍝

```
rails import:recipes
```

## Start the server

```
bin/dev
```
