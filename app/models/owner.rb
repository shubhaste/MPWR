class Owner < ActiveRecord::Base
	belongs_to :company
  validates :name,:nationality,:gender,:phone,:email,:birth_date,:national_id,:passport_number,:national_id_expiry_date,:passport_number_expiry_date, presence: true
	#has_one :passport_proof, :dependent => :destroy
	#has_one :national_proof, :dependent => :destroy
	#accepts_nested_attributes_for :passport_proof, :allow_destroy => true
	#accepts_nested_attributes_for :national_proof, :allow_destroy => true
	has_attached_file :passport_attachment, 
    :path => ":rails_root/public/system/:class/passport/:id/:basename_:style.:extension",
    :url => "/system/:class/passport/:id/:basename_:style.:extension",
    :styles => {
      :thumb    => ['100x100#',  :jpg, :quality => 70],
      :preview  => ['480x480#',  :jpg, :quality => 70],
      :large    => ['600>',      :jpg, :quality => 70],
      :retina   => ['1200>',     :jpg, :quality => 30],
      :pdf_thumbnail => ["100x100#", :jpg, :quality => 70]
    },
    :convert_options => {
      :thumb    => '-set colorspace sRGB -strip',
      :preview  => '-set colorspace sRGB -strip',
      :large    => '-set colorspace sRGB -strip',
      :retina   => '-set colorspace sRGB -strip -sharpen 0x0.5'
    }

  validates_attachment :passport_attachment,
    :presence => true,
    :size => { :in => 0..10.megabytes },
    :content_type => { :content_type =>  [/^image\/(jpeg|png|gif|tiff)$/, 'application/pdf'] }

    has_attached_file :national_attachment, 
    :path => ":rails_root/public/system/:class/national/:id/:basename_:style.:extension",
    :url => "/system/:class/national/:id/:basename_:style.:extension",
    :styles => {
      :thumb    => ['100x100#',  :jpg, :quality => 70],
      :preview  => ['480x480#',  :jpg, :quality => 70],
      :large    => ['600>',      :jpg, :quality => 70],
      :retina   => ['1200>',     :jpg, :quality => 30],
      :pdf_thumbnail => ["100x100#", :jpg, :quality => 70]
    },
    :convert_options => {
      :thumb    => '-set colorspace sRGB -strip',
      :preview  => '-set colorspace sRGB -strip',
      :large    => '-set colorspace sRGB -strip',
      :retina   => '-set colorspace sRGB -strip -sharpen 0x0.5'
    }

  validates_attachment :national_attachment,
    :presence => true,
    :size => { :in => 0..10.megabytes },
    :content_type => { :content_type =>  [/^image\/(jpeg|png|gif|tiff)$/, 'application/pdf'] }
end
