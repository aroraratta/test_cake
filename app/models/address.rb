class Address < ApplicationRecord
  belongs_to :customer
  
  def finally_address
    '〒' + postal_code + ' ' + destination + ' ' + name
  end
end
