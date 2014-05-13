json.array!(@products) do |product|
  json.extract! product, :id, :title, :description, :image_url, :unit_price
  json.url product_url(product, format: :json)
end
