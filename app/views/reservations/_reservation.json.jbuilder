json.extract! reservation, :id, :email, :department, :typology, :space, :floor, :seat, :start_date, :end_date, :state, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
