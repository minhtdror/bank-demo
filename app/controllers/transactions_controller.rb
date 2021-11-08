class TransactionsController < ApplicationController
  before_action :authenticate_user!
  # GET accounts/1/transactions
  def index
    @account = Account.find_by(id: params[:account_id])
    if @account = Account.find_by(id: params[:account_id])
      if policy(@account).show?
        @transactions = @account.transactions
      else
        msg = "You are not authorized to perform this action"
        flash[:error] = msg
        redirect_back(fallback_location: root_path)
      end
    else
      msg = "You are not authorized to perform this action"
      flash[:error] = msg
      redirect_back(fallback_location: root_path)
    end
  end

  # GET accounts/1/transactions/1
  def show
    if @account = Account.find_by(id: params[:account_id])
      if policy(@account).show?
        @transaction = @account.transactions.find(params[:id])
      else
        msg = "You are not authorized to perform this action"
        flash[:error] = msg
        redirect_back(fallback_location: root_path)
      end
    else
      msg = "You are not authorized to perform this action"
      flash[:error] = msg
      redirect_back(fallback_location: root_path)
    end
  end

  # GET accounts/1/transactions/new
  def new
    if @account = Account.find_by(id: params[:account_id])
      if policy(@account).update?
        @transaction = @account.transactions.build
      else
        msg = "You are not authorized to perform this action"
        flash[:error] = msg
        redirect_back(fallback_location: root_path)
      end
    else
      msg = "You are not authorized to perform this action"
      flash[:error] = msg
      redirect_back(fallback_location: root_path)
    end
  end

  # POST accounts/1/transactions
  def create
    @account = Account.find_by(id: params[:account_id])
    if policy(@account).update?
      @transaction = @account.transactions.build(transaction_params)
      balance = @account.balance
      ActiveRecord::Base.transaction do
        @transaction.save!
        if @transaction.transaction_type == Transaction.transaction_types.key('withdraw')
          balance = balance - @transaction.amount
        else
          balance = balance + @transaction.amount
        end
        @account.update!(balance: balance)
      end
      respond_to do |format|
         if @transaction.id.present?
          format.html { redirect_to account_transaction_path(@account.id, @transaction), notice: "Transaction was successfully created." }
        else
          format.html { render :new }
        end
      end
    else
      msg = "You are not authorized to perform this action"
      flash[:error] = msg
      redirect_back(fallback_location: root_path)
    end
  rescue
    @transaction.errors.add(:base, "Transaction error")
    render :new
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @account = Account.find_by(id: params[:account_id])
      @transaction = @account.transactions.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:amount, :transaction_type)
    end
end
