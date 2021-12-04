class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :product, null: false, foreign_key: true
      t.references :order_list, null: false, foreign_key: true
      t.integer :amount, null: false

      t.timestamps
    end
  end
end
