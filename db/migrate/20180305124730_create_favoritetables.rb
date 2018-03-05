class CreateFavoritetables < ActiveRecord::Migration[5.0]
  def change
    create_table :favoritetables do |t|
      t.references :user, foreign_key: true
      t.references :favorite, foreign_key: { to_table: :microposts }

      t.timestamps
    end
  end
end
