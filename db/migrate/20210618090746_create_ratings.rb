# frozen_string_literal: true

class CreateRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :ratings do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.integer :rate, null: false
      t.string :content

      t.timestamps
    end
  end
end
