class AddSelectedToCandidates < ActiveRecord::Migration[6.0]
  def change
    add_column :candidates, :selected, :boolean
  end
end
