class CompaniesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  respond_to :html

  def index

    if current_user.has_role? :staff
     @companies = Company.all
    elsif current_user.has_role? :director
    @companies = Company.joins(:certificates).where.not(:certificates => {workflow_state: ['inititated','pending']})
     elsif current_user.has_role? :minister
    @companies = Company.joins(:certificates).where.not(:certificates => {workflow_state: ['inititated','pending','awaiting_for_director_approval']})
    else
    @companies = Company.all
    end 

    respond_to do |format|
      format.html 
    end  
  end

  def show
   # respond_with(@company)
     @company = Company.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @company }
    end
  end

  def new
    @company = Company.new
    #respond_with(@company)
    #@project = Project.new
    1.times do
      @company.owners.build
      @company.attachments.build
      @company.certificates.build
    end
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @company }
    end
  end

  def edit
    @company = Company.find(params[:id])
  end

  def create
    @company = Company.new(company_params)
    #@company.save
    #respond_with(@company)
    #@project = Project.new(params[:project])
    puts @company.certificates.first.user_id = current_user.id
    respond_to do |format|
      if @company.save
        @company.certificates.first.submit!
        #format.html { redirect_to(@company, :notice => 'Project was successfully created.') }
        format.html { redirect_to(company_certificate_path(@company,@company.certificates.first), :notice => 'Certficate was successfully created.') }
        format.xml  { render :xml => @company, :status => :created, :location => @company }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end


 def update
    @company = Company.find(params[:id])

    respond_to do |format|
      if @company.update_attributes(company_params)
        #format.html { redirect_to(@company, :notice => 'Project was successfully updated.') }
        format.html { redirect_to(company_certificate_path(@company,@company.certificates.first), :notice => 'Certficate was successfully created.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
   # @company.destroy
   # respond_with(@company)
    @company = Company.find(params[:id])
    @company.destroy

    respond_to do |format|
      format.html { redirect_to(companies_url) }
      format.xml  { head :ok }
  end
end
  def approve

  end
  
  def reject

  end
   
  private
    def set_company
      @company = Company.find(params[:id])
    end

    def company_params
      #params.require(:company).permit(:name, :address, attachments_attributes:[ :_destroy, :id, :attachment ], owners_attributes: [:id, :name, :_destroy, national_proof_attributes: [:id, :national_id, :_destroy], passport_proof_attributes: [:id, :passport_no, :_destroy]] )
      params.require(:company).permit(:name, :address, attachments_attributes:[ :_destroy, :id, :attachment, :description ], owners_attributes: [:id, :name, :_destroy, :passport_attachment,:national_attachment,:phone,:nationality,:email,:gender,:birth_date,:national_id,:passport_number,:national_id_expiry_date,:passport_number_expiry_date ],certificates_attributes:[ :_destroy, :id, :cert_issue_date,:cert_eff_date,:cert_term_date, :description ] )
    end
end
