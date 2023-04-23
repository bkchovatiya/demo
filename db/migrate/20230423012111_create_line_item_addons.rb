class CreateLineItemAddons < ActiveRecord::Migration[7.0]
  def change
    create_table :line_item_addons do |t|
      t.integer :line_item_id
      t.integer :product_addon_id
      t.timestamps
    end
  end
end
