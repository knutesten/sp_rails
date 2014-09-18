class CreateProtocols < ActiveRecord::Migration
  def change
    create_table :protocols do |t|
      t.string     :ware,         null: false
      t.money      :price,        null: false
      t.money      :amount_owed,  null: false
      t.references :buyer,        null: false, index: true
      t.references :debtor,       null: false, index: true

      t.timestamps
    end
  end
end
