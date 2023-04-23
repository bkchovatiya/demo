class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :quantity
      t.boolean :sold_out, default: false
      t.timestamps
    end
  end
end
