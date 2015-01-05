class AddBirthDateToOwners < ActiveRecord::Migration
  def change
    add_column :owners, :birth_date, :datetime
    add_column :owners, :national_id, :string
    add_column :owners, :national_id_expiry_date, :datetime
    add_column :owners, :passport_number, :string
    add_column :owners, :passport_number_expiry_date, :datetime
  end
end
