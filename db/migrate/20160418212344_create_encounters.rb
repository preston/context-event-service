class CreateEncounters < ActiveRecord::Migration
  def change
    create_table :encounters, id: :uuid do |t|
      t.string :external_id
      t.uuid :user_id,  null: false
      t.uuid :issue_id,  null: false
      t.uuid :context_id,   null: false
      t.datetime :started_at
      t.datetime :ended_at

      t.timestamps null: false
    end
    add_foreign_key :encounters,    :users
    add_foreign_key :encounters,    :issues
    add_foreign_key :encounters,    :contexts
  end
end
