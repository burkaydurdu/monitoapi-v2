class CreateTodos < ActiveRecord::Migration[6.1]
  def change
    create_table :todos, id: :uuid do |t|
      t.text :content, null: false
      t.boolean :done, null: false, default: false
      t.references :user, type: :uuid, null: false
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
