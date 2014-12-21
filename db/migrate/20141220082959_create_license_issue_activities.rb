class CreateLicenseIssueActivities < ActiveRecord::Migration
  def change
    create_table :license_issue_activities do |t|
      t.string :status, :null => false
      t.integer :certificate_id, :null => false
      t.integer :user_id, :null => false
      t.timestamps
    end
  end
end
