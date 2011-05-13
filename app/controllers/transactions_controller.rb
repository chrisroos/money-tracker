class TransactionsController < ApplicationController
  
  def index
    @transactions = Transaction.all
  end
  
  def edit
    @transaction = Transaction.find(params[:id])
  end
  
  def update
    transaction = Transaction.find(params[:id])
    transaction.update_attributes(params[:transaction])
    redirect_to transactions_path
  end
  
  def search
    @transactions = Transaction.search(params[:q])
    render :index
  end
  
end