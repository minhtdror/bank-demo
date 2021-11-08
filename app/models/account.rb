class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions, dependent: :destroy

  enum bank: {'Ngân hàng thương mại cổ phần Ngoại thương Việt Nam': 'VCB', 'Ngân hàng thương mại cổ phần Á Châu': 'ACB', 'Ngân hàng Thương mại Cổ phần Quốc tế Việt Nam': 'VIB'}

  validates :name, :bank, presence: true
  validates :balance, numericality: { greater_than_or_equal_to: 0 }
end
