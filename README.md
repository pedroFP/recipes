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

## Start the app

```
bin/dev
```

### Tsvector

Comparison when searching with and without tsvector

**With**

```ruby
class Recipe < ApplicationRecord
  include PgSearch
  pg_search_scope :search_by_ingredients,
                  against: :ingredients_text,
                  using: {
                    tsearch: {
                      tsvector_column: "ingredients_tsv"
                    }
                  }
end
```

```sql
3.2.0 :001 > Recipe.search_ingredients("milk").count
  Recipe Count (8.2ms)  SELECT COUNT(*) FROM "recipes" WHERE (ingredients @> ARRAY['milk']::varchar[]) /*application='RecipesApp'*/
 => 1
```

**Without**

```ruby
class Recipe < ApplicationRecord
  scope :search_ingredients, ->(ingredients) { where("ingredients @> ARRAY[?]::varchar[]", ingredients) }
end

```

```sql
3.2.0 :001 > Recipe.search_by_ingredients("milk").count
  Recipe Count (9.1ms)  SELECT COUNT(*) FROM "recipes" INNER JOIN (SELECT "recipes"."id" AS pg_search_id, (ts_rank(("recipes"."ingredients_tsv"), (to_tsquery('simple', ''' ' || 'milk' || ' ''')), 0)) AS rank FROM "recipes" WHERE (("recipes"."ingredients_tsv") @@ (to_tsquery('simple', ''' ' || 'milk' || ' ''')))) AS pg_search_63b8bd59a482879ad0634d ON "recipes"."id" = pg_search_63b8bd59a482879ad0634d.pg_search_id /*application='RecipesApp'*/
 => 1817
```
