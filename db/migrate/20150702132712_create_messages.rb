class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|

      t.references :evaluation, index: true

      t.text :content
      t.boolean :read
      t.string :recipient

      t.timestamps null: false
    end
  end
end
