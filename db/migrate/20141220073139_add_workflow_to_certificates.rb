class AddWorkflowToCertificates < ActiveRecord::Migration
  def change
    add_column :certificates, :workflow_state, :string
  end
end
