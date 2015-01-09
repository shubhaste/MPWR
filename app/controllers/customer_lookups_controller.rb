class CustomerLookupsController < ApplicationController


	def search
		#@data = search_by_query(params[:search_company_id], params[:search_owner_name], params[:search_company_name])
	    respond_to do |format|
	      format.html
	    end 
	end

	def list_all
		@data = search_by_query(params[:search_company_id], params[:search_owner_name], params[:search_company_name])
	    respond_to do |format|
	      format.html
	    end 
	end

	private

	def search_by_query(company_id, owner_name, company_name)
		if (company_id.blank?)
			sql_query = "select distinct cmp.id as CompanyId, own.name as OwnerName,cmp.name as CompanyName, cer.description as CerDescription,lia1.status as CerStatus,lia1.updated_at as CertLastActivity from owners own 
			              inner join companies cmp on own.company_id=cmp.id 
			              inner join certificates cer on cer.company_id=own.company_id 
			              inner join  license_issue_activities lia1 on lia1.certificate_id=cer.id 
			              inner join  license_issue_activities lia2 on lia1.certificate_id=lia2.certificate_id 
			              where  own.name LIKE '%#{owner_name}%' and cmp.name LIKE '%#{company_name}%'
			              GROUP BY cmp.id,own.name,cmp.name,cer.description,lia1.status 
			              HAVING lia1.updated_at=MAX(lia2.updated_at)
			              ORDER BY cmp.id,own.name,cmp.name,cer.description,lia1.status"
		else
			sql_query = "select distinct cmp.id as CompanyId, own.name as OwnerName,cmp.name as CompanyName, cer.description as CerDescription,lia1.status as CerStatus,lia1.updated_at as CertLastActivity from owners own 
			              inner join companies cmp on own.company_id=cmp.id 
			              inner join certificates cer on cer.company_id=own.company_id 
			              inner join  license_issue_activities lia1 on lia1.certificate_id=cer.id 
			              inner join  license_issue_activities lia2 on lia1.certificate_id=lia2.certificate_id 
			              where  cmp.id='#{company_id}' and own.name LIKE '%#{owner_name}%' and cmp.name LIKE '%#{company_name}%'
			              GROUP BY cmp.id,own.name,cmp.name,cer.description,lia1.status 
			              HAVING lia1.updated_at=MAX(lia2.updated_at)
			              ORDER BY cmp.id,own.name,cmp.name,cer.description,lia1.status"
		end
		#results = ActiveRecord::Base.connection.exec_query(sql_query).rows
		results = ActiveRecord::Base.connection.select_all(sql_query).to_a
	end

end
