class Company < ActiveRecord::Base
	has_many :owners, :dependent => :destroy
	accepts_nested_attributes_for :owners, :allow_destroy => true
	has_many :attachments, :dependent => :destroy
	accepts_nested_attributes_for :attachments, :allow_destroy => true
end
