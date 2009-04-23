class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.column :email,      :string
      t.column :pay_type,   :string, :limit => 10
      t.column :status,     :integer
      t.column :address_id, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
