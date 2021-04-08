class MerchantsFacade
  def self.index(per_page=20, page=1)
    if page < 1
      page = 1
    end
    start = (page - 1) * per_page
    Merchant.offset(start).first(per_page)
  end

  def self.show(id)
    Merchant.find(id)
  end

  def self.find_items(id)
    Merchant.find(id).items
  end
end
