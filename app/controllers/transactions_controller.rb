class TransactionsController < ApplicationController
  
  def index
    redirect_to current_period_transactions_path unless params[:period]
    
    @transactions = Transaction.period(params[:period])
    render :edit if params[:edit]
  end
  
  def update
    transaction = Transaction.find(params[:id])
    transaction.update_attributes(params[:transaction])
    if request.xhr?
      render :text => 'OK'
    else
      redirect_to :back
    end
  end
  
  def search
    @transactions = Transaction.search(params[:q])
  end
  
end