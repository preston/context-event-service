class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles, id: :uuid do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.text :description

      t.timestamps null: false
    end
    add_index :roles, :name, unique: true
    add_index :roles, :code, unique: true
  end
end
