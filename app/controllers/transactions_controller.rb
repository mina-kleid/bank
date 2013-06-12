class TransactionsController < ApplicationController
  before_filter :load_user,:authenticate_user
  def new
    @transaction=Transaction.new
    @transaction.from_account=@user.account.id

  end
  def create
    @transaction=Transaction.new
    @transaction.from_account=params[:transaction][:from_account]
    @transaction.to_account=params[:transaction][:to_account]
    @transaction.amount=params[:transaction][:amount]
    if @transaction.save
      flash[:notice]= "Transaction completed successfully"
      redirect_to user_path(:id => @user.id)
    else
      render :new
    end
  end
  private
  def load_user
    @user=User.find(params[:user_id])
  end
end
