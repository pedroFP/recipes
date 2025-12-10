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

### Tsvector

> Tsvector is 19.90 times faster

With tsvector | `Recipe Count (7.2ms)`

```ruby
3.2.0 :004 > Recipe.search_by_ingredients("yeast").count
  Recipe Count (7.2ms)  SELECT COUNT(*) FROM "recipes" INNER JOIN (SELECT "recipes"."id" AS pg_search_id, (ts_rank(("recipes"."ingredients_tsv"), (to_tsquery('simple', ''' ' || 'yeast' || ' ''')), 0)) AS rank FROM "recipes" WHERE (("recipes"."ingredients_tsv") @@ (to_tsquery('simple', ''' ' || 'yeast' || ' ''')))) AS pg_search_63b8bd59a482879ad0634d ON "recipes"."id" = pg_search_63b8bd59a482879ad0634d.pg_search_id /*application='RecipesApp'*/
 => 656
```

Without tsvector | `Recipe Count (143.3ms)`

```ruby
3.2.0 :006 > Recipe.search_by_ingredients("yeast").count
  Recipe Count (143.3ms)  SELECT COUNT(*) FROM "recipes" INNER JOIN (SELECT "recipes"."id" AS pg_search_id, (ts_rank((to_tsvector('simple', coalesce(("recipes"."ingredients_text")::text, ''))), (to_tsquery('simple', ''' ' || 'yeast' || ' ''')), 0)) AS rank FROM "recipes" WHERE ((to_tsvector('simple', coalesce(("recipes"."ingredients_text")::text, ''))) @@ (to_tsquery('simple', ''' ' || 'yeast' || ' ''')))) AS pg_search_63b8bd59a482879ad0634d ON "recipes"."id" = pg_search_63b8bd59a482879ad0634d.pg_search_id /*application='RecipesApp'*/
 => 656
```
