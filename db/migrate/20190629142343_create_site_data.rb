class CreateSiteData < ActiveRecord::Migration[5.1]
  def change
    create_table :site_data do |t|
      t.string :url
      t.integer :rank
      t.text :content

      t.timestamps
    end
  end
end
