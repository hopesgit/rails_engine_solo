class MerchantsFacade
  def self.index(per_page=20, page=1)
    start = (page - 1) * per_page
    Merchant.first(per_page)
  end
end
