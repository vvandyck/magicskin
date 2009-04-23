class Address < ActiveRecord::Base
  has_many :orders

  validates_presence_of  :first_name, :last_name, :address_1, :town, :country_code

end
