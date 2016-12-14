class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :payment_id
      t.decimal :amount
      t.string :state
      t.references :user, foreign_key: true
      t.references :article, foreign_key: true

      t.timestamps
    end
  end
end
