require 'rails_helper'

describe InvoiceItem do
  describe 'validations' do
    it { should validate_presence_of :quantity }
    it { should validate_numericality_of :quantity }
    it { should validate_presence_of :item_id }
    it { should validate_presence_of :invoice_id }
  end

  describe 'relationships' do
    it { should belong_to :invoice }
    it { should belong_to :item }
  end
end
