class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.column :skin_id, :integer, :null => false
      t.column :name, :string
    end
  end

  def self.down
    drop_table :images
  end
end
