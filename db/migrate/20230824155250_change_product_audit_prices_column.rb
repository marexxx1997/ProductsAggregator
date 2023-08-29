class ChangeProductAuditPricesColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :product_audit_prices, :product_audit_image_id, :product_audit_id
    add_foreign_key :product_audit_prices, :product_audits, column: :product_audit_id
  end
end
