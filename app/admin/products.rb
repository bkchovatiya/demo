ActiveAdmin.register Product do
  permit_params :name, :sold_out, product_addons_attributes: [:id, :name, :sold_out]

  index do
    selectable_column
    id_column
    column :name
    column :sold_out
    column :created_at
    actions
  end

  filter :name
  filter :sold_out
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :sold_out
      f.has_many :product_addons, for: [:product_addons, f.object.product_addons || f.object.product_addons.new], allow_destroy: true do |product_addon|
        product_addon.input :name
        product_addon.input :sold_out
      end
    end
    f.actions
  end

  show do |product|
    attributes_table do
      rows :name, :sold_out, :created_at
    end

    if product.product_addons.present?
      panel "Product Addons" do
        table_for product.product_addons do
          column :name
          column :sold_out
        end
      end
    end
  end
end
