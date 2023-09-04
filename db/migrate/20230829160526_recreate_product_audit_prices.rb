class RecreateProductAuditPrices < ActiveRecord::Migration[6.0]
  def up
    drop_table :product_audit_prices

    create_table :product_audit_prices do |t|
      t.float :price
      t.references :product_audit, foreign_key: true
      t.references :platform_product, foreign_key: true
      t.timestamps
    end
  end

  def down
    drop_table :product_audit_prices
  end
end
