class UploadsController < ApplicationController
  
  def new
    @upload = Upload.new
  end
  
  def create
    upload = Upload.new(params[:upload])
    StatementImporter.import(upload.ofx_file)
    redirect_to transactions_path
  end
  
end