class AddAttachmentPassportAttachmentToOwners < ActiveRecord::Migration
  def self.up
    change_table :owners do |t|
      t.attachment :passport_attachment
    end
  end

  def self.down
    remove_attachment :owners, :passport_attachment
  end
end
