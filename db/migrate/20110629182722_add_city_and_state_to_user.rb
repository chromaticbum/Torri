class AddCityAndStateToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :state, :string
    add_column :users, :city, :string
  end

  def self.down
    remove_column :users, :state
    remove_column :users, :city
  end
end
