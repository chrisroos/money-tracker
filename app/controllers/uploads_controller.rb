class UploadsController < ApplicationController

  def new
    @upload = Upload.new
  end

  def create
    @upload = Upload.new(params[:upload])
    if @upload.valid?
      imported, duplicates = StatementImporter.import(@upload.ofx_file)
      flash[:info] = "#{imported} transactions were imported.  #{duplicates} duplicate transactions were ignored."
      redirect_to current_period_transactions_path
    else
      flash.now[:info] = "Please select the OFX file to upload"
      render :new
    end
  end

end