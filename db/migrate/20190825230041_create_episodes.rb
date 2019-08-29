class CreateEpisodes < ActiveRecord::Migration[5.2]
  def change
    create_table :episodes do |t|
      t.string :title
      t.date :date
      t.text :track_data

      t.timestamps
    end
  end
end
