class Protocol < ActiveRecord::Base
  validates :ware, length: { minimum: 3 }
  validates :price, numericality: { greater_than: 0 }
  validates :amount_owed, numericality: { greater_than_or_equal_to: 0 }

  monetize :price_Øres
  monetize :amount_owed_Øres

  belongs_to :buyer, class_name: 'User'
  belongs_to :debtor, class_name: 'User'
end
