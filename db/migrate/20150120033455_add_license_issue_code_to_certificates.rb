class AddLicenseIssueCodeToCertificates < ActiveRecord::Migration
  def change
    add_column :certificates, :license_issue_code, :string
  end
end
