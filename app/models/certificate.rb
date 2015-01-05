class Certificate < ActiveRecord::Base
	belongs_to :company
  has_many :license_issue_activities
  validates :remarks, presence: true, :if => lambda{  !remarks.nil? }
  validates :description, presence: true, :if => lambda{  !description.nil? }
  include Workflow
  workflow do
    state :initiated do
      event :submit, :transitions_to => :pending
    end
    state :pending do
      event :ready_approval, :transitions_to => :awaiting_for_director_approval
    end
    state :awaiting_for_director_approval do
      event :director_accept, :transitions_to => :awaiting_for_minister_approval
      event :director_reject, :transitions_to => :director_has_rejected
    end
    state :awaiting_for_minister_approval do
      event :minister_reject, :transitions_to => :minister_has_rejected
      event :minister_accept, :transitions_to => :minister_has_accepted
    end
    state :minister_has_accepted do
      event :revoke, :transitions_to => :revoked
      event :issue_license, :transitions_to => :license_issued
    end
    state :license_issued do
      event :revoke, :transitions_to => :revoked
    end
    state :revoked do
      event :reinstate, :transitions_to => :reinstated
    end
    state :reinstated do
     event :issue_license, :transitions_to => :license_issued
      event :revoke, :transitions_to => :revoked
    end
    state :minister_has_rejected
  end

  def submit
    puts 'sending email to the author explaining the reason...'
    l = LicenseIssueActivity.new
    l.user_id = User.current.id
    l.certificate_id = id
    l.status = 'initiated'
    l.save!
  end 

  def director_accept
    puts 'sending email to the author explaining the reason...'
    l = LicenseIssueActivity.new
    l.user_id = User.current.id
    l.certificate_id = id
    l.remarks = remarks
    l.status = 'director has accepted'
    l.save!
  end 
  
  def director_reject
    puts 'sending email to the author explaining the reason...'
    l = LicenseIssueActivity.new
    l.user_id = User.current.id
    l.certificate_id = id
    l.remarks = remarks
    l.status = 'director has rejected'
    l.save!
  end 

  def minister_accept
    puts 'sending email to the author explaining the reason...'
    l = LicenseIssueActivity.new
    l.user_id = User.current.id
    l.certificate_id = id
    l.remarks = remarks
    l.status = 'minister has accepted'
    l.save!
  end 

  def minister_reject
    puts 'sending email to the author explaining the reason...'
    l = LicenseIssueActivity.new
    l.user_id = User.current.id
    l.certificate_id = id
    l.remarks = remarks
    l.status = 'minister has rejected'
    l.save!
  end 

  def revoke
    puts 'sending email to the author explaining the reason...'
    l = LicenseIssueActivity.new
    l.user_id = User.current.id
    l.certificate_id = id
    l.remarks = remarks
    l.status = 'revoked'
    l.save!
  end 

  def reinstate
    puts 'sending email to the author explaining the reason...'
    l = LicenseIssueActivity.new
    l.user_id = User.current.id
    l.certificate_id = id
    l.remarks = remarks
    l.status = 'reinstated'
    l.save!
  end 

  def issue_license
    puts 'sending email to the author explaining the reason...'
    l = LicenseIssueActivity.new
    l.user_id = User.current.id
    l.certificate_id = id
    l.status = 'License Issued'
    l.save!
  end  
end
