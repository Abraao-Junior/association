class AddIndexToDebtsAmount < ActiveRecord::Migration[7.1]
  def change
    add_index :debts, :amount
  end
end
