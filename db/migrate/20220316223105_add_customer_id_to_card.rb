class AddCustomerIdToCard < ActiveRecord::Migration[7.0]
  def change
    add_column :cards, :customer_id, :integer
  end
end
