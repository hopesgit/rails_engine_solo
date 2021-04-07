class MerchantsFacade
  def self.index(per_page=20, page=1)
    start = (page - 1) * per_page
    Merchant.offset(start).first(per_page)
  end

  def self.show(id)
    Merchant.find(id)
  end
end
