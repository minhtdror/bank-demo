class Transaction < ApplicationRecord
  belongs_to :account

  enum transaction_type: {'Withdraw': 'withdraw', 'Deposit': 'deposit'}

  validates :amount, :transaction_type, presence: true

end
