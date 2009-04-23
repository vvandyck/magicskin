class Skin < ActiveRecord::Base
  belongs_to :user
  has_many :images

  validates_presence_of :width, :height
  validates_numericality_of :width, :greater_than => 0, :less_than => 1000
  validates_numericality_of :height, :greater_than => 0, :less_than => 800
  
  def self.public_skins
    Skin.all :conditions =>{:public=>true, :active=>true}
  end


end
