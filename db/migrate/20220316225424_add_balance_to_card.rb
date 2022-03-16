class AddBalanceToCard < ActiveRecord::Migration[7.0]
  def change
    add_column :cards, :balance, :float
  end
end
