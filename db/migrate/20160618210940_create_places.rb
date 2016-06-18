class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places, id: :uuid do |t|
      t.string :name,	null: false
      t.text :address
      t.text :description

      t.timestamps null: false
    end
  end
end
