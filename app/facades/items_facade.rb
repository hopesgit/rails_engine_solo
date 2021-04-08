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
end
