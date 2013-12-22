class TransactionsController < ApplicationController

  def index
    redirect_to current_period_transactions_path unless params[:period]

    @filter = "for #{Date.from_period(params[:period]).to_s(:month_and_year)}"
    @transactions = Transaction.period(params[:period])
    render :bulk_edit if params[:edit].present?
  end

  def edit
    @transaction = Transaction.find(params[:id])
  end

  def update
    transaction = Transaction.find(params[:id])
    transaction.update_attributes(params[:transaction].permit(:date, :description, :location, :note, :category))
    if request.xhr?
      render text: 'OK'
    else
      redirect_to :back
    end
  end

  def search
    @filter =  "matching '#{params[:q]}'"
    @transactions = Transaction.search(params[:q])
    render :bulk_edit if params[:edit].present?
  end

end
