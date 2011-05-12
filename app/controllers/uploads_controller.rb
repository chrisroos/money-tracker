class UploadsController < ApplicationController
  
  def new
    @upload = Upload.new
  end
  
  def create
    upload = Upload.new(params[:upload])
    imported, duplicates = StatementImporter.import(upload.ofx_file)
    flash[:info] = "#{imported} transactions were imported.  #{duplicates} duplicate transactions were ignored."
    redirect_to transactions_path
  end
  
end