ActiveAdmin.register Order do
  index do
    selectable_column
    id_column
    column("Customer"){|o| o.customer.first_name }
    column :state
    column :created_at
    actions
  end

  member_action :approve do
    order = Order.find_by(id: params[:id])
    order.update(state: 'completed')
    redirect_to admin_order_path(order)
  end

  action_item :complete_order, only: :show do
    link_to('Mark Order as Complete', approve_admin_order_path(order)) unless order.completed?
  end

  show do |order|
    attributes_table do
      rows :state, :created_at
    end

    if order.customer.present?
      panel "Customer" do
        table_for order.customer do
          column :first_name
          column :last_name
          column :email
          column :mobile_no
          column :address
        end
      end
    end

    if order.line_items.present?
      panel "Order Products" do
        table_for order.line_items do
          column("Product"){|o| o.product.name }
          column("Product Addons") {|a| a.product_addons.pluck(:name)}
          column("Quantity") {|o| o.quantity}
        end
      end
    end
  end
end
