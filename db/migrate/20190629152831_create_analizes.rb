class CreateAnalizes < ActiveRecord::Migration[5.1]
  def change
    create_table :analizes do |t|
      t.references :site_data, foreign_key: true
      t.json :result

      t.timestamps
    end
  end
end
