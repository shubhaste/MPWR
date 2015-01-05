class CertificatesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_certificate, only: [:show, :edit, :update, :destroy,:ready_approval,:pending,:director_reject,:director_accept,:minister_reject,:minister_accept,:revoke,:reinstate,:issue_license]
  before_action :set_company
  #, only: [:index, :new, :edit, :create, :show, :update, :destroy,:director_reject,:director_accept,:minister_reject,:minister_accept]
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
      pdf.draw_text @certificate.description, :at => [200,305], :size => 20
      pdf.draw_text @certificate.cert_issue_date.to_date.strftime('%v'), :at => [140,280], :size => 20
      pdf.draw_text @certificate.cert_term_date.to_date.strftime('%v'), :at => [450,272], :size => 20
    
      
      
      pdf.draw_text @company.name, :at => [290,198], :size => 20
      pdf.draw_text @certificate.description, :at => [280,170], :size => 20
        pdf.draw_text @certificate.cert_issue_date.to_date.strftime('%v'), :at =>  [250,135], :size => 20
      pdf.draw_text @certificate.cert_term_date.to_date.strftime('%v'), :at => [600,130], :size => 20
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
        #Notifier.send_email.deliver
        #ActionMailer::Base.mail(:from => "pbs@hypertechsolutions.com", :to => "prashanth.bsp@gmail.com", :subject => "test", :body => "test").deliver
        format.html { redirect_to(company_certificate_path(@company,@certificate), :notice => 'Certficate was successfully created.') }
        format.xml  { render :xml => @certificate, :status => :created, :location => @certificate }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @certificate.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update

      # if params[:remarks].nil?  or  !params[:remarks].blank? 
        @certificate.update(certificate_params)
        if @certificate.update_attributes(certificate_params)
            if  params[:commit_director] == 'Accept License' 
                director_accept
            elsif  params[:commit_director] == 'Reject License'  
               director_reject
            elsif  params[:commit_minister] == 'Accept License'  
               minister_accept
            elsif  params[:commit_minister] == 'Reject License'  
               minister_reject   
            elsif  params[:commit_revoke] == 'Revoke License'  
               revoke   
            elsif  params[:commit_reinstate] == 'Reinstate License'  
               reinstate   
            else 
             respond_to do |format| 
                format.html { redirect_to(company_certificate_path(@company,@certificate), :notice => 'Certificate was successfully updated.') }
                format.xml  { head :ok }
              end  
            end 
        else
          respond_to do |format| 
            if params[:remarks].nil? 
             format.html { render :action => "show" }
             format.xml  { render :xml => @certificate.errors, :status => :unprocessable_entity }
           else
            format.html { render :action => "edit" }
            format.xml  { render :xml => @certificate.errors, :status => :unprocessable_entity }
          end
         end 
        end 
      #else
      #respond_to do |format| 
      #  format.html { redirect_to(company_certificate_path(@company,@certificate), :notice => 'Certificate was successfully updated.') }
      #  format.xml  { head :ok }
      #end  
      #end  
    end
 

  def destroy
    @certificate.destroy
    respond_with(@certificate)
  end
  
  def ready_approval
    if @certificate.ready_approval!
       @u = User.all
       @u.each do |director|
       if  director.has_role? :director
        puts director.email
         begin
            ActionMailer::Base.mail(:from =>'no-reply@hawlahaguud.com',:to => director.email, :subject => "Ministry of Public Works & Reconstruction of The Minister ", :body => "Hi #{director.username},awaiting your approval for license activity #{@certificate.description}").deliver
          rescue => e
            logger.warn "Unable to foo, will ignore: #{e}" 
          end
         end 
     end 
     respond_to do |format|
      format.html { redirect_to(company_certificate_path(@company,@certificate), :notice => 'ready for approval success.') }
     end
   end  
  end
    
  def director_accept
    if @certificate.director_accept!
       @u = User.all
       @u.each do |minister|
       if  minister.has_role? :minister
         begin
            ActionMailer::Base.mail(:from =>'no-reply@hawlahaguud.com',:to => minister.email, :subject => "Ministry of Public Works & Reconstruction of The Minister ", :body => "Hi #{minister.username},awaiting your approval for license #{@certificate.description}").deliver
          rescue => e
            logger.warn "Unable to foo, will ignore: #{e}" 
          end
         end 
     end 
     respond_to do |format|
      format.html { redirect_to(company_certificate_path(@company,@certificate), :notice => 'Director has accepted.') }
     end
   end
  end

  def director_reject
     if @certificate.director_reject!
       respond_to do |format|
          format.html { redirect_to(company_certificate_path(@company,@certificate), :notice => 'Director has rejected.') }
       end 
     end   
  end

  def minister_accept
    if @certificate.minister_accept!
    @certificate.company.owners.each do |owner|
      begin
        ActionMailer::Base.mail(:from =>'no-reply@hawlahaguud.com',:to => owner.email, :subject => "Ministry of Public Works & Reconstruction of The Minister ", :body => "Hi #{owner.name},We have accepted your license for #{@certificate.description},please do contact us for more").deliver
      rescue => e
        logger.warn "Unable to foo, will ignore: #{e}" 
      end
    end
     respond_to do |format|
      format.html { redirect_to(company_certificate_path(@company,@certificate), :notice => 'License is accepted.') }
     end
   end
  end

  def minister_reject
     if @certificate.minister_reject!
       @certificate.company.owners.each do |owner| 
         begin
          ActionMailer::Base.mail(:from =>'no-reply@hawlahaguud.com',:to => owner.email, :subject => "Ministry of Public Works & Reconstruction of The Minister ", :body => "Hi #{owner.name},Your license for #{@certificate.description} has been rejected,please do contact us for more").deliver
        rescue => e
          logger.warn "Unable to foo, will ignore: #{e}" 
        end
       end 
       respond_to do |format|
          format.html { redirect_to(company_certificate_path(@company,@certificate), :notice => 'Rejected successfully.') }
       end 
     end   
  end

  def revoke
     if @certificate.revoke!
        @certificate.company.owners.each do |owner| 
         begin
          ActionMailer::Base.mail(:from =>'no-reply@hawlahaguud.com', :to => owner.email, :subject => "Ministry of Public Works & Reconstruction of The Minister ", :body => "Hi #{owner.name},Your license for #{@certificate.description} has been revoked/cancelled,please do contact us for more").deliver
        rescue => e
          logger.warn "Unable to foo, will ignore: #{e}" 
        end
      end
       respond_to do |format|
          format.html { redirect_to(company_certificate_path(@company,@certificate), :notice => 'License is revoked.') }
       end 
     end   
  end

  def reinstate
     if @certificate.reinstate!
        @certificate.company.owners.each do |owner| 
         begin
           ActionMailer::Base.mail(:from =>'no-reply@hawlahaguud.com',:to => owner.email, :subject => "Ministry of Public Works & Reconstruction of The Minister ", :body => "Hi #{owner.name},Your license for #{@certificate.description} has been reinstated,please do contact us for more").deliver
        rescue => e
          logger.warn "Unable to foo, will ignore: #{e}" 
        end
      end
       respond_to do |format|
          format.html { redirect_to(company_certificate_path(@company,@certificate), :notice => 'License is reinstated.') }
       end 
     end   
  end

  def issue_license
     if @certificate.issue_license!
         @certificate.company.owners.each do |owner| 
          begin
           ActionMailer::Base.mail(:from =>'no-reply@hawlahaguud.com',:to => owner.email, :subject => "Ministry of Public Works & Reconstruction of The Minister ", :body => "Hi #{owner.name},Certificate for license  #{@certificate.description} has been generated,please do contact us for more").deliver
        rescue => e
          logger.warn "Unable to foo, will ignore: #{e}" 
        end
       end
       respond_to do |format|
          format.html { redirect_to(companies_path, :notice => 'License issued successfully.') }
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
      params.require(:certificate).permit(:description, :cert_issue_date, :cert_eff_date, :cert_term_date, :remarks, :commit_director, :commit_minister,:commit_revoke,:commit_reinstate  )
    end
end
