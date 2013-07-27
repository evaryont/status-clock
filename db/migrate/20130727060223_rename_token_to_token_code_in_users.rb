class RenameTokenToTokenCodeInUsers < ActiveRecord::Migration
  def change
    rename_column :users, :token, :token_code
  end
end
