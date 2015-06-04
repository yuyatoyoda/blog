class ChangeColumnToArticle < ActiveRecord::Migration
  def up
    change_column :articles, :next, :text
  end

  def down
    change_column :articles, :next, :date
  end
end
