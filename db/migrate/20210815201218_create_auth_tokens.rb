class CreateAuthTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :auth_tokens, id: :uuid do |t|
      t.string     :token, limit: 43
      t.references :user, type: :uuid, null: false
      t.datetime   :deleted_at

      t.timestamps
    end
  end
end
