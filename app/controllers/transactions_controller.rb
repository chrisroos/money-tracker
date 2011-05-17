class TransactionsController < ApplicationController
  
  def index
    @transactions = Transaction.all
  end
  
  def update
    transaction = Transaction.find(params[:id])
    transaction.update_attributes(params[:transaction])
    if request.xhr?
      render :text => 'OK'
    else
      redirect_to transactions_path(:edit => true)
    end
  end
  
  def search
    @transactions = Transaction.search(params[:q])
    render :index
  end
  
end