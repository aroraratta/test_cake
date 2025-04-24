class Order < ApplicationRecord
  has_many :order_details
  belongs_to :customer
  has_many :items, through: :order_details

  enum payment_method: { credit_card: 0, transfer: 1 }
  
  def finally_address
    '〒' + postal_code + ' ' + destination + ' ' + name
  end
end
