class UploadsController < ApplicationController
  
  def new
    @upload = Upload.new
  end
  
  def create
    upload = Upload.new(params[:upload])
    duplicates = StatementImporter.import(upload.ofx_file)
    flash[:info] = "#{duplicates} duplicate transactions were ignored" if duplicates > 0
    redirect_to transactions_path
  end
  
end