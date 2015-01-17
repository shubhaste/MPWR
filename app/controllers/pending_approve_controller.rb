class PendingApproveController < ApplicationController

	def list_all
		#@data = search_by_query(params[:search_company_id], params[:search_owner_name], params[:search_company_name])
	    @data = search_by_query()
	    respond_to do |format|
	      format.html
	    end 
	end




	private

	def search_by_query()
		
			sql_query = "select distinct cmp.id as CompanyId, own.name as OwnerName,cmp.name as CompanyName, cer.description as CerDescription,lia1.status as CerStatus,DATE_FORMAT(lia1.updated_at,'%m-%d-%Y %h:%i %p') as CertLastActivity from owners own 
			              inner join companies cmp on own.company_id=cmp.id 
			              inner join certificates cer on cer.company_id=own.company_id 
			              inner join  license_issue_activities lia1 on lia1.certificate_id=cer.id 
			              inner join  license_issue_activities lia2 on lia1.certificate_id=lia2.certificate_id 
			          
			              GROUP BY cmp.id,own.name,cmp.name,cer.description,lia1.status,lia1.updated_at 
			              HAVING lia1.updated_at=MAX(lia2.updated_at)
			              ORDER BY cmp.id,own.name,cmp.name,cer.description,lia1.status"

		
		#results = ActiveRecord::Base.connection.exec_query(sql_query).rows
		results = ActiveRecord::Base.connection.select_all(sql_query).to_a
	end

end
