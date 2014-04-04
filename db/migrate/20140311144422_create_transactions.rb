class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :amount
      t.references :src_account
      t.references :dst_account

      t.timestamps
    end
  end
end
