class AddRefreshTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :refresh_token, :string
    rename_column :users, :token_code, :access_token
  end
end
