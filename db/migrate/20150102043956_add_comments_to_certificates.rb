class AddCommentsToCertificates < ActiveRecord::Migration
  def change
    add_column :certificates, :remarks, :string
  end
end
