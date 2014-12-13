class CreateCertificates < ActiveRecord::Migration
  drop_table :certificates
  def change
    create_table :certificates do |t|
      t.string :description		
	    t.datetime :cert_issue_date, :null => false
      t.datetime :cert_eff_date, :null => false
      t.datetime :cert_term_date, :null => false
      t.integer :user_id, :null => false
      t.integer :company_id, :null => false
      t.timestamps
     end
  end
end
