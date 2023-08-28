class RemovePlatformProductIdFromScans < ActiveRecord::Migration[6.0]
  def change
    remove_column :scans, :platform_product_id, :integer
  end
end
