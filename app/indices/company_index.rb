  ThinkingSphinx::Index.define :company, :with => :real_time do
    # fields
    indexes :name, :sortable => true

    joins owners
    joins certificates
    
    # has owner_ids, :type => :integer
    # has certificate_ids, :type => :integer

    # attributes
    #has  created_at, updated_at
  end