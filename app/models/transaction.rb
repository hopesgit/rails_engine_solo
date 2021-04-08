class Transaction < ApplicationRecord
  validates :invoice_id, presence: true
  validates :credit_card_number, presence: true, length: { is: 16 }
  validates :credit_card_expiration_date, presence: true, format: { with: /(0[0-9]|1[0-2])\/([0-9][0-9])/, message: "accepts only the format MM/YY" }
  validates :result, presence: true, inclusion: { in: %w(refunded success failed) }
  belongs_to :invoice
end
