class CreateSkins < ActiveRecord::Migration
  def self.up
    create_table :skins do |t|
      t.column :name,    :string
      t.column :width,   :integer
      t.column :height,  :integer
      t.column :price,   :decimal, :precision => 8, :scale => 2, :default => 0
      t.column :public,  :boolean, :default => false
      t.column :active,  :boolean, :default => true
      t.column :user_id, :integer
    end
  end

  def self.down
    drop_table :skins
  end
end
