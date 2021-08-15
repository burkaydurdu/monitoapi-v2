class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string   :name, null: false
      t.string   :surname, null: false
      t.string   :email, null: false, index: { unique: true }
      t.string   :password_digest, null: false
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
