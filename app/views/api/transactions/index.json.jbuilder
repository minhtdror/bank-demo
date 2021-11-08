if @user
  json.array! @transactions, partial: "api/transactions/transaction", as: :transaction
else
  json.array "User is not exists"
end
