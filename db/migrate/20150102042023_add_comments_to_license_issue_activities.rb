class AddCommentsToLicenseIssueActivities < ActiveRecord::Migration
  def change
    add_column :license_issue_activities, :remarks, :string
  end
end
