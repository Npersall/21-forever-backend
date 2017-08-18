class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string  :name,      null: false
      t.text    :badge_url, null: false

      t.timestamps
    end
  end
end
