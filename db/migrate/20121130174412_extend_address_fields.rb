class ExtendAddressFields < ActiveRecord::Migration
  def self.up
    change_table :spree_addresses do |t|
      t.string :title
      t.string :additional_title
    end
  end

  def self.down
    change_table :spree_addresses do |t|
      t.remove :title
      t.remove :additional_title
    end
  end
end