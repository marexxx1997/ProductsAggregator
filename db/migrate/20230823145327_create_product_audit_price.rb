class CreateProductAuditPrice < ActiveRecord::Migration[6.0]
  def change
    create_table :product_audit_prices do |t|
      t.float :price
      
      t.references :product_audit_image, foreign_key: true
      t.references :platform_product, foreign_key: true

      t.timestamps
    end
  end
end
