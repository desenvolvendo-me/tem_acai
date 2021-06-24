class AddAddressToCompany < ActiveRecord::Migration[6.0]
  def change
    add_reference :companies, :address, null: true, foreign_key: true
  end
end
