class AddServiceToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :service, :string
  end
end
