class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string  :description
      t.string  :attachment
	    t.integer :company_id
      t.string  :attachment_file_name
      t.string  :attachment_content_type
      t.integer :attachment_file_size
      t.timestamps
    end
  end
end
