class RemoveForeignKeyFromScans < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :scans, :platform_products
  end
end
