class AddColumnsToPassportProofs < ActiveRecord::Migration
  def change
  	  add_column :passport_proofs, :name, :string
  	  add_column :passport_proofs, :type, :string
  	  add_column :passport_proofs, :country_code, :string
  	  add_column :passport_proofs, :mother_name, :string
  	  add_column :passport_proofs, :nationality, :string
  	  add_column :passport_proofs, :occupation, :string
  	  add_column :passport_proofs, :gender, :string
  	  add_column :passport_proofs, :place_of_birth, :string
  	  add_column :passport_proofs, :birth_date, :datetime
  	  add_column :passport_proofs, :issue_date, :datetime
  	  add_column :passport_proofs, :place_of_issue, :string
  	  add_column :passport_proofs, :issuing_authority, :string
  	  add_column :passport_proofs, :expiry_date, :datetime
  end
end
