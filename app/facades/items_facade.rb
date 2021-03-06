class ItemsFacade
  def self.index(per_page=20, page=1)
    if page < 1
      page = 1
    end
    start = (page - 1) * per_page
    Item.offset(start).first(per_page)
  end

  def self.show(id)
    Item.find(id)
  end

  def self.new_item(info)
    Item.create(info)
  end

  def self.update(id, params)
    Item.find(id).update(params)
    Item.find(id)
  end

  def self.destroy(id)
    Item.destroy(id)
  end

  def self.find_merchant(item_id)
    Item.find(item_id).merchant
  end
end
