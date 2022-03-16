json.extract! customer, :id, :name, :address, :created_at, :updated_at
json.url customer_url(customer, format: :json)
