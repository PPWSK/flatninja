class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.boolean :status

      t.references :room, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
