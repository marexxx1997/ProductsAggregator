class ChangeSelectedDefaultInCandidates < ActiveRecord::Migration[6.0]
  def change
    change_column_default :candidates, :selected, false
  end
end
