class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues, id: :uuid do |t|
      t.string :external_id
      t.uuid :user_id, null: false
      t.uuid :problem_id, null: false

      t.timestamps null: false
    end
    add_foreign_key :issues, :users
    add_foreign_key :issues, :problems
  end
end
