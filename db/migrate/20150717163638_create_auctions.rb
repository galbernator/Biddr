class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.string :title
      t.text :details
      t.datetime :end_date
      t.integer :reserve_price
      t.integer :current_bid
      t.references :user, index: true, foreign_key: true
      t.string :aasm_state

      t.timestamps null: false
    end
  end
end
