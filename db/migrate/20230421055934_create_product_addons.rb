class CreateProductAddons < ActiveRecord::Migration[7.0]
  def change
    create_table :product_addons do |t|
      t.integer :product_id
      t.string :name
      t.integer :quantity
      t.boolean :sold_out, default: false
      t.timestamps
    end
  end
end
