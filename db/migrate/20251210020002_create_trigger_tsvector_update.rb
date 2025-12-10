class CreateTriggerTsvectorUpdate < ActiveRecord::Migration[8.0]
  def up
    sql = <<~SQL
      CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE
      ON recipes FOR EACH ROW EXECUTE FUNCTION
      tsvector_update_trigger(ingredients_tsv, 'pg_catalog.simple', ingredients_text);
    SQL
    ActiveRecord::Base.connection.execute(sql)
  end

  def down
    sql = <<~SQL
      DROP TRIGGER IF EXISTS tsvectorupdate ON recipes;
    SQL

    ActiveRecord::Base.connection.execute(sql)
  end
end
