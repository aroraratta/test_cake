class Order < ApplicationRecord
  enum payment_method: { credit_card: 0, transfer: 1 }
  
  def finally_address
    '〒' + postal_code + ' ' + destination + ' ' + name
  end
end
