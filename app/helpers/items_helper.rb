module ItemsHelper
  def status_options
    ITEM_STATUS_HASH.to_a.unshift([nil, "全て"])
  end
end
