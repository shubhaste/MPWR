class AddAttachmentNationalAttachmentToOwners < ActiveRecord::Migration
  def self.up
    change_table :owners do |t|
      t.attachment :national_attachment
    end
  end

  def self.down
    remove_attachment :owners, :national_attachment
  end
end
