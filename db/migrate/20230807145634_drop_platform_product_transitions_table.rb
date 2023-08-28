class DropPlatformProductTransitionsTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :platform_product_transitions
  end
end
