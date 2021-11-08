class AccountPolicy < ApplicationPolicy
  attr_reader :user, :account
  def initialize user, account
    @user = user
    @account = account
  end

  def update?
    @user.accounts.include?(@account)
  end

  def edit?
    @user.accounts.include?(@account)
  end

  def show?
    @user.accounts.include?(@account)
  end

  def destroy?
    @user.accounts.include?(@account)
  end

end
