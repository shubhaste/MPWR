class CustomerLookupsController < ApplicationController


	def search
	    respond_to do |format|
	      format.html
	    end 
	end

	def list_all
		@data = search_by_sphinx(params[:search_company_id], params[:search_owner_name], params[:search_company_name])
	    respond_to do |format|
	      format.html
	    end 
	end

	private

	def search_by_sphinx(company_id, owner_name, company_name)
		owners_by_name 	  = search_by_owner_name(owner_name)
		owners_by_company = search_by_company_name(company_name)
		owner_by_id 	  = search_by_company_id(company_id)

		final_results = owners_by_name + owners_by_company + owner_by_id
		final_results.uniq
	end


	def search_by_query(company_id, owner_name, company_name)
		if (company_id.blank?)
			sql_query = "select distinct cmp.id as CompanyId, own.name as OwnerName,cmp.name as CompanyName, cer.description as CerDescription,lia1.status as CerStatus,DATE_FORMAT(lia1.updated_at,'%m-%d-%Y %h:%i %p') as CertLastActivity from owners own 
                    inner join companies cmp on own.company_id=cmp.id 
                    inner join certificates cer on cer.company_id=own.company_id 
                    inner join  license_issue_activities lia1 on lia1.certificate_id=cer.id 
                    inner join  license_issue_activities lia2 on lia1.certificate_id=lia2.certificate_id 
                    where  own.name LIKE '%#{owner_name}%' and cmp.name LIKE '%#{company_name}%'
                    GROUP BY cmp.id,own.name,cmp.name,cer.description,lia1.status,lia1.updated_at  
                    HAVING lia1.updated_at=MAX(lia2.updated_at)
                    ORDER BY cmp.id,own.name,cmp.name,cer.description,lia1.status"
        else
        	sql_query = "select distinct cmp.id as CompanyId, own.name as OwnerName,cmp.name as CompanyName, cer.description as CerDescription,lia1.status as CerStatus,DATE_FORMAT(lia1.updated_at,'%m-%d-%Y %h:%i %p') as CertLastActivity from owners own 
                    inner join companies cmp on own.company_id=cmp.id 
                    inner join certificates cer on cer.company_id=own.company_id 
                    inner join  license_issue_activities lia1 on lia1.certificate_id=cer.id 
                    inner join  license_issue_activities lia2 on lia1.certificate_id=lia2.certificate_id 
                    where  cmp.id='#{company_id}' and own.name LIKE '%#{owner_name}%' and cmp.name LIKE '%#{company_name}%'
                    GROUP BY cmp.id,own.name,cmp.name,cer.description,lia1.status,lia1.updated_at 
                    HAVING lia1.updated_at=MAX(lia2.updated_at)
                    ORDER BY cmp.id,own.name,cmp.name,cer.description,lia1.status"
		end
		#results = ActiveRecord::Base.connection.exec_query(sql_query).rows
		results = ActiveRecord::Base.connection.select_all(sql_query).to_a
	end

	def search_by_company_name(company_name)
		companies = Company.search (company_name) unless company_name.blank?
		ids = companies.map(&:id) unless company_name.blank?
		owners = Owner.where(:company_id => ids) unless ids.blank?
		owners.blank? ? [] : owners.to_a
	end

	def search_by_owner_name(owner_name)
		owner = Owner.search (owner_name) unless owner_name.blank?
		owner.blank? ? [] : owner
	end

	def search_by_company_id(company_id)
		comp = Company.find_by_id(company_id) unless company_id.blank?
		owner = Owner.where(:company_id => comp.id) unless comp.blank?
		owner.blank? ? [] : owner.to_a
	end
end
