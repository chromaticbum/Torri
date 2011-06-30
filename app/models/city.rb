class City < ActiveRecord::Base
  validates_uniqueness_of :name, :case_sensitive => false, :scope => :state_id
  validates_presence_of :name
  validates_length_of :name, :minimum => 2

  belongs_to :state
end
