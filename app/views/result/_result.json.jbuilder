json.extract! result, :id, :first_name, :last_name, :email, :phone, :twitter, :created_at, :updated_at
json.url result_url(result, format: :json)
