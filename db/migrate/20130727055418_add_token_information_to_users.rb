class AddTokenInformationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :token, :string
    add_column :users, :expires_at, :datetime
  end
end
