class AddUserInfoToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :dob, :string
    add_column :posts, :full_name, :string
    add_column :posts, :email_address, :string
  end
end
