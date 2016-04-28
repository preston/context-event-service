class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities, id: :uuid do |t|
      t.uuid :user_id,  null: false
      t.uuid :provider_id,  null: false
      t.string :sub,    null: false
      t.string :iat
      t.string :hd
      t.string :locale
      t.string :email
      t.json     :jwt,                                default: {},    null: false
      t.boolean  :notify_via_email,                   default: false, null: false
      t.boolean  :notify_via_sms,                     default: false, null: false

      t.timestamps null: false
    end
    add_foreign_key :identities,    :users
    add_foreign_key :identities,    :providers
  end
end
