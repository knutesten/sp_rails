json.array!(@protocols) do |protocol|
  json.extract! protocol, :id, :ware, :price_cents, :amount_owed_cents, :buyer_id, :debtor_id
  json.url protocol_url(protocol, format: :json)
end
