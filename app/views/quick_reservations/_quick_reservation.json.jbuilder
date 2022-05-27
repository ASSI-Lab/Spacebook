json.extract! quick_reservation, :id, :email, :department, :typology, :space, :created_at, :updated_at
json.url quick_reservation_url(quick_reservation, format: :json)
