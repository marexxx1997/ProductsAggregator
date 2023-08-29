class CreateCandidates < ActiveRecord::Migration[6.0]
  def change
    create_table :candidates do |t|
      t.string :name
      t.string :url
      t.string :image_url

      t.references :platform_product, foreign_key: true

      t.timestamps
    end
  end
end
