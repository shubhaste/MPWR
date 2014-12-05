class CreatePassportProofs < ActiveRecord::Migration
  def change
    create_table :passport_proofs do |t|
      t.string :passport_no
      t.string :owner_id

      t.timestamps
    end
  end
end
