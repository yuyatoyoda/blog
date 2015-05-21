class ChangeColumnToUser < ActiveRecord::Migration
  def change
    change_column :users, :token, :string, limit: 500
  end
end
