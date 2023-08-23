class CreatePlatforms < ActiveRecord::Migration[6.0]
  def change
    create_table :platforms do |t|
      t.string :name
      t.string :logo_url
      t.string :url

      t.timestamps
    end
  end
end
