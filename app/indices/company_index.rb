  ThinkingSphinx::Index.define :company, :with => :active_record do
    # fields
    indexes :name, :sortable => true
    indexes certificates.description, :as => :description, :sortable => true
    
    # attributes
    has  created_at, updated_at
  end