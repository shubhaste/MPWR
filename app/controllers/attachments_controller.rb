class AttachmentsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_attachment, only: [:pdf]

  def pdf
  	send_file @attachment.attachment.path, :type => @attachment.attachment.content_type
   end

   private
    def set_attachment
      @attachment = Attachment.find(params[:id])
    end


end
