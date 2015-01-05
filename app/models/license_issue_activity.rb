class LicenseIssueActivity < ActiveRecord::Base
	belongs_to :certificate
	belongs_to :user
end
