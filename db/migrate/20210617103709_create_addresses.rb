# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :zip
      t.string :street
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end
