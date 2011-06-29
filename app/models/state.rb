class State < ActiveRecord::Base
  validates_uniqueness_of :name, :if => :name_changed?
  validates_presence_of :name
  validates_length_of :name, :minimum => 2

  has_many :cities
end
