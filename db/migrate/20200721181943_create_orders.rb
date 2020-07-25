class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :address
      t.string :email
      t.integer :pay_type

      t.timestamps
    end
  end
end
