class Api::TransactionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  # GET api/users/1/transactions
  def index
    if @user = User.find_by(id: params[:user_id])
      @transactions = if params[:account_id]
                        Transaction.where(account: @user.accounts.find(params[:account_id]))
                      else
                        Transaction.where(account: @user.accounts)
                      end
    else
      render json: {success: false, message: "User is not exists"}
    end
  end

  # GET api/users/1/transactions/1
  def show
    if @user = User.find_by(id: params[:user_id])
      @transaction = Transaction.find(params[:id])
    else
      render json: {success: false, message: "User is not exists"}
    end
  end

  # POST api/users/1/transactions
  def create
    if @user = User.find_by(id: params[:user_id])
      if @account = @user.accounts.find_by(id: params[:account_id])
        balance = @account.balance
        @transaction = @account.transactions.build
        ActiveRecord::Base.transaction do
          @transaction.amount = params[:amount]
          @transaction.transaction_type = params[:transaction_type]
          @transaction.save!
          if @transaction.transaction_type == Transaction.transaction_types.key('withdraw')
            balance = balance - @transaction.amount
          else
            balance = balance + @transaction.amount
          end
          @account.update!(balance: balance)
        end
        render :show, status: :created, location: api_transaction_path(@user, @transaction) 
      else
        render json: {success: false, message: "Account bank is not exists"}
      end
    else
      render json: {success: false, message: "User is not exists"}
    end
  rescue => e
    render json: {success: false, message: e}
  end

  private
    def transaction_params
        params.permit(:account_id, :amount, :transaction_type)
    end
end
