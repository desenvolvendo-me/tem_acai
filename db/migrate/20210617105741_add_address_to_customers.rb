class AddAddressToCustomers < ActiveRecord::Migration[6.0]
  def change
    add_reference :customers, :address, null: true, foreign_key: true
  end
end
