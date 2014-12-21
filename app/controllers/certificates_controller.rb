class CertificatesController < ApplicationController
  before_action :set_certificate, only: [:show, :edit, :update, :destroy,:director_reject,:director_accept,:minister_reject,:minister_accept]
  before_action :set_company, only: [:index, :new, :edit, :create, :show, :update, :destroy,:director_reject,:director_accept,:minister_reject,:minister_accept]
  respond_to :html

  def index
    @certificates = @company.certificates
    respond_with(@certificates)
  end

  def show
   # respond_with(@certificate)
    respond_to do |format|
    format.html 
    format.pdf do
      img = "#{Rails.root}/app/assets/images/certificate.png"
      pdf = Prawn::Document.new(background: img, :page_size => [631,868], :margin => 0.5, :page_layout => :landscape)
      pdf.font "Times-Roman"
      pdf.draw_text @certificate.id, :at => [200,368], :size => 20
      pdf.draw_text @company.name, :at => [200,329], :size => 20
      pdf.draw_text @certificate.cert_issue_date, :at => [140,280], :size => 20
      pdf.draw_text @certificate.cert_term_date, :at => [450,280], :size => 20
      pdf.draw_text @certificate.cert_issue_date, :at => [140,280], :size => 20
      pdf.draw_text @certificate.description, :at => [200,305], :size => 20
      send_data pdf.render, filename: "mycertficate.pdf",
                      type: "application/pdf"
    end
  end
  end

  def new
    #@certificate = Certificate.new
    @certificate = @company.certificates.new
    respond_with(@certificate)
  end

  def edit
   # respond_with(@certificate)
   # edit_company_certificate_path
  end

  def create
    @certificate = @company.certificates.new(certificate_params)
    @certificate.user_id = current_user.id
    #@certificate.save
    #respond_with(@certificate)

    respond_to do |format|
      if @certificate.save
         @certificate.submit!
        format.html { redirect_to(company_certificates_path(@company), :notice => 'Certficate was successfully created.') }
        format.xml  { render :xml => @certificate, :status => :created, :location => @certificate }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @certificate.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @certificate.update(certificate_params)
      respond_to do |format|
        if @certificate.update_attributes(certificate_params)
          format.html { redirect_to(company_certificates_path(@company), :notice => 'Certificate was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @certificate.errors, :status => :unprocessable_entity }
        end
    end
  end

  def destroy
    @certificate.destroy
    respond_with(@certificate)
  end

  def director_accept
    if @certificate.director_accept!
     respond_to do |format|
      format.html { redirect_to(company_certificates_path(@company), :notice => 'Review was successfully updated.') }
     end
   end
  end

  def director_reject
     if @certificate.director_reject!
       respond_to do |format|
          format.html { redirect_to(company_certificates_path(@company), :notice => 'Reject was successfully updated.') }
       end 
     end   
  end

  def minister_accept
    if @certificate.minister_accept!
     respond_to do |format|
      format.html { redirect_to(company_certificates_path(@company), :notice => 'Review was successfully updated.') }
     end
   end
  end

  def minister_reject
     if @certificate.minister_reject!
       respond_to do |format|
          format.html { redirect_to(company_certificates_path(@company), :notice => 'Reject was successfully updated.') }
       end 
     end   
  end

  private
    def set_certificate
      @certificate = Certificate.find(params[:id])
    end

    def set_company
      @company = Company.find(params[:company_id])
    end

    def certificate_params
      params.require(:certificate).permit(:description, :cert_issue_date, :cert_eff_date, :cert_term_date )
    end
end
