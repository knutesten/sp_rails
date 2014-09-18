class Protocol < ActiveRecord::Base
  monetize :price_Øres
  monetize :amount_owed_Øres

  belongs_to :buyer,   class_name: 'User'
  belongs_to :debtor,  class_name: 'User'
end
