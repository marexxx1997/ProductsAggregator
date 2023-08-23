class CreatePlatformProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :platform_products do |t|
      t.string :url
      t.string :state

      t.references :product, foreign_key: true
      t.references :platform, foreign_key: true

      t.timestamps
    end
  end
end
