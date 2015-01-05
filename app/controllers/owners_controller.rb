class OwnersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_owner, only: [:passport_pdf,:national_pdf]

   def passport_pdf
  	send_file @owner.passport_attachment.path, :type => @owner.passport_attachment.content_type
   end
   
   def national_pdf
  	send_file @owner.national_attachment.path, :type => @owner.national_attachment.content_type
   end

   private
    def set_owner
      @owner = Owner.find(params[:id])
    end


end
