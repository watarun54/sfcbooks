module ItemsHelper
  def status_options
    ITEM_STATUS_HASH.to_a.unshift([nil, "全て"])
  end

  def item_image(item)
    return image_tag(item.images.first.path.url, class: "card-img-top") if item.images.size > 0
    image_tag("no-image", class: "card-img-top")
  end
end
