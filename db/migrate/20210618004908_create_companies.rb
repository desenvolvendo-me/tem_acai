# frozen_string_literal: true

class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.string :phone
      t.boolean :is_open, default: false
      t.decimal :acai_price, precision: 10, scale: 2
      t.boolean :reservation, default: false
      t.boolean :delivery, default: false

      t.timestamps
    end
  end
end
