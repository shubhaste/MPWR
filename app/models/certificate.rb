class Certificate < ActiveRecord::Base
	belongs_to :company
  has_many :license_issue_activity
  include Workflow
  #workflow do
  #  state :new do
  #    event :submit, :transitions_to => :awaiting_review
  #  end
  #  state :awaiting_review do
  #    event :review, :transitions_to => :being_reviewed
  #  end
  #  state :being_reviewed do
  #    event :accept, :transitions_to => :accepted
  #    event :reject, :transitions_to => :rejected
  #  end
  #  state :accepted
  #  state :rejected
  #end
  workflow do
    state :initiated do
      event :submit, :transitions_to => :awaiting_director_approval
    end
    state :awaiting_director_approval do
      event :director_reject, :transitions_to => :director_rejected
      event :director_accept, :transitions_to => :awaiting_minister_approval
    end
    state :awaiting_minister_approval do
      event :minister_reject, :transitions_to => :minister_rejected
      event :minister_accept, :transitions_to => :minister_accepted
    end
    state :director_rejected
    state :minister_accepted
    state :minister_rejected
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
    l.status = 'director_accept'
    l.save!
  end 
  def director_reject
    puts 'sending email to the author explaining the reason...'
    l = LicenseIssueActivity.new
    l.user_id = User.current.id
    l.certificate_id = id
    l.status = 'director_reject'
    l.save!
  end 
   def minister_reject
    puts 'sending email to the author explaining the reason...'
    l = LicenseIssueActivity.new
    l.user_id = User.current.id
    l.certificate_id = id
    l.status = 'minister_rejected'
    l.save!
  end 
   def minister_accept
    puts 'sending email to the author explaining the reason...'
    l = LicenseIssueActivity.new
    l.user_id = User.current.id
    l.certificate_id = id
    l.status = 'minister_accepted'
    l.save!
  end 
end
