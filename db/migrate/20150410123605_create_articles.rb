class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :shinchoku
      t.text :kansou
      t.text :manabi
      t.date :next
      t.date :next_date
      t.text :memo
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
