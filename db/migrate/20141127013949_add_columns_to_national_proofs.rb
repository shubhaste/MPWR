class AddColumnsToNationalProofs < ActiveRecord::Migration
  def change
  	  add_column :national_proofs, :name, :string
  	  add_column :national_proofs, :birth_date, :datetime
  	  add_column :national_proofs, :issue_date, :datetime
  	  add_column :national_proofs, :expiry_date, :datetime
  	  add_column :national_proofs, :gender, :string
  	  add_column :national_proofs, :nationality, :string
  end
end
