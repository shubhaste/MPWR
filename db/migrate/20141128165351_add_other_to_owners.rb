class AddOtherToOwners < ActiveRecord::Migration
  def change
    add_column :owners, :nationality, :string
    add_column :owners, :phone, :string
    add_column :owners, :email, :string
    add_column :owners, :gender, :string
  end
end
