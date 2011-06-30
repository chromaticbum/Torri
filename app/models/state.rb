class State < ActiveRecord::Base
  validates_uniqueness_of :name, :case_sensitive => false, :if => :name_changed?
  validates_presence_of :name
  validates_length_of :name, :minimum => 2

  has_many :cities, :dependent => :destroy
end
