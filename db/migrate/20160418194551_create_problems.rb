class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems, id: :uuid do |t|
      t.string :external_id,    null: true
      t.string :name,   null: false

      t.timestamps null: false
    end
  end
end
