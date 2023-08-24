class CreateScans < ActiveRecord::Migration[6.0]
  def change
    create_table :scans do |t|
      t.references :platform_product, foreign_key: true

      t.timestamps
    end
  end
end
