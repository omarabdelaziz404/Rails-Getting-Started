class CreateDummies < ActiveRecord::Migration[8.1]
  def change
    create_table :dummies do |t|
      t.string :name
      t.integer :age
      t.datetime :born_at

      t.timestamps
    end
  end
end
