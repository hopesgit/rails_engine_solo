class InvoiceItem < ApplicationRecord
  validates :quantity, numericality: true, presence: true
  validates :item_id, presence: true
  validates :invoice_id, presence: true

  belongs_to :item
  belongs_to :invoice
end
