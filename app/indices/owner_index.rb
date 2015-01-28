  ThinkingSphinx::Index.define :owner, :with => :real_time do
    # fields
    indexes :name, :sortable => true
    indexes company.name, :as => :company_name, :sortable => true

    # attributes
    #has "company_id", created_at, updated_at
  end