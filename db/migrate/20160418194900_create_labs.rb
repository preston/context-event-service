class CreateLabs < ActiveRecord::Migration
  def change
    create_table :labs, id: :uuid do |t|
      t.string :external_id
      t.uuid :user_id,  null: false
      t.datetime :ordered_at
      t.datetime :requested_at

      t.timestamps null: false
    end
    add_foreign_key :labs, :users
  end
end
