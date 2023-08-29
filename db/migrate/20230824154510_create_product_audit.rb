class CreateProductAudit < ActiveRecord::Migration[6.0]
  def change
    create_table :product_audits do |t|
      t.string :image_url
      
      t.references :product, foreign_key: true
      t.references :scan, foreign_key: true

      t.timestamps
    end
  end
end
