class CreateLineItems < ActiveRecord::Migration
  def self.up
    create_table :line_items do |t|
      t.column :skin_id,            :integer, :null => false
      t.column :name,               :string
      t.column :order_id,           :integer, :null => false
      t.column :unit_price,         :integer, :null => false
      t.column :quantity,           :integer, :null => false
      t.column :unit_postage,       :integer
      t.column :total_price,        :decimal, :null => false, :precision => 8, :scale => 2
    end

    execute "alter table line_items add constraint fk_line_item_skins
           foreign key (skin_id) references skins(id)"
    execute "alter table line_items add constraint fk_line_item_orders
           foreign key (order_id) references orders(id)"
  end
  
  def self.down
    drop_table :line_items
  end
end
