json.array!(@books) do |book|
  json.extract! book, :title, :published_at, :isbn, :published_id, :blurb, :page_count, :price
  json.url book_url(book, format: :json)
end