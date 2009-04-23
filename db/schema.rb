# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090422120038) do

  create_table "addresses", :force => true do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "address_1"
    t.string "address_2"
    t.string "town"
    t.string "postcode"
    t.string "country_code"
  end

  create_table "images", :force => true do |t|
    t.integer "skin_id", :null => false
    t.string  "name"
  end

  create_table "line_items", :force => true do |t|
    t.integer "skin_id",                                    :null => false
    t.integer "order_id",                                   :null => false
    t.integer "unit_price",                                 :null => false
    t.integer "quantity",                                   :null => false
    t.integer "unit_postage"
    t.decimal "total_price",  :precision => 8, :scale => 2, :null => false
  end

  add_index "line_items", ["order_id"], :name => "fk_line_item_orders"
  add_index "line_items", ["skin_id"], :name => "fk_line_item_skins"

  create_table "orders", :force => true do |t|
    t.string   "email"
    t.string   "pay_type",   :limit => 10
    t.integer  "status"
    t.integer  "address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "roles_users", ["role_id"], :name => "index_roles_users_on_role_id"
  add_index "roles_users", ["user_id"], :name => "index_roles_users_on_user_id"

  create_table "skins", :force => true do |t|
    t.integer "width"
    t.integer "height"
    t.boolean "public",                               :default => false
    t.boolean "active",                               :default => true
    t.decimal "price",  :precision => 8, :scale => 2
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
  end

end
