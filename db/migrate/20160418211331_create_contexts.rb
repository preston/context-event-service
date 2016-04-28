class CreateContexts < ActiveRecord::Migration
  def change
    create_table :contexts, id: :uuid do |t|
      t.string :name,   null: false
      t.string :scope

      t.timestamps null: false
    end
  end
end
