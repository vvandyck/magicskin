class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.column :first_name,     :string
      t.column :last_name,      :string
      t.column :address_1,      :string
      t.column :address_2,      :string
      t.column :town,           :string
      t.column :postcode,       :string
      t.column :country_code,   :string
    end
  end

  def self.down
    drop_table :addresses
  end
end
