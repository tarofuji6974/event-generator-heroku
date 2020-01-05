class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title
      t.text :candidate_date
      t.text :memo
      t.text :url
      t.text :candidate_count

      t.timestamps
    end
  end
end
