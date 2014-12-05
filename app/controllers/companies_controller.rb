class CompaniesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  respond_to :html

  def index
    #@companies = Company.all
    #respond_with(@companies)
        @companies = Company.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @companies }
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

    respond_to do |format|
      if @company.save
        format.html { redirect_to(@company, :notice => 'Project was successfully created.') }
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
        format.html { redirect_to(@company, :notice => 'Project was successfully updated.') }
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
      params.require(:company).permit(:name, :address, attachments_attributes:[ :_destroy, :id, :attachment, :description ], owners_attributes: [:id, :name, :_destroy, :passport_attachment,:national_attachment,:phone,:nationality,:email,:gender ] )
    end
end
