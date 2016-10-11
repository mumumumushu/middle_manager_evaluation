class CreateEvaluations < ActiveRecord::Migration[5.0]
  def change
    create_table :evaluations do |t|
      t.text :thought_morals
      t.text :upright_incorruptiable
      t.text :duties
      t.integer :evaluation
      t.references :user , polymorphic: true

      t.timestamps
    end
  end
end
