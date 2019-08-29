class AddCurrentToEpisodes < ActiveRecord::Migration[5.2]
  def change
    add_column :episodes, :current, :boolean, default: false
    add_index :episodes, :current
  end
end
