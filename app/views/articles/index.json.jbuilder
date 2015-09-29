json.array!(@articles) do |article|
  json.extract! article, :id, :title, :content, :url
  json.url article_url(article, format: :json)
end
