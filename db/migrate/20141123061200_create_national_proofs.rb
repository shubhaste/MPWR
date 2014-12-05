class CreateNationalProofs < ActiveRecord::Migration
  def change
    create_table :national_proofs do |t|
      t.string :national_id
      t.string :owner_id

      t.timestamps
    end
  end
end
