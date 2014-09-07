class Protocol < ActiveRecord::Base
  monetize :price_cents
  monetize :amount_owed_cents

  belongs_to :buyer,   class_name: 'User'
  belongs_to :debtor,  class_name: 'User'
end
