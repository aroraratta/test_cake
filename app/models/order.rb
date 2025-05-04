class Order < ApplicationRecord
  has_many :order_details
  belongs_to :customer
  has_many :items, through: :order_details

  enum payment_method: { credit_card: 0, transfer: 1 }
  
  def create_order_details(customer)
    unless order_details.first
      cart_items = customer.cart_items.includes(:item)
      cart_items.each do |cart_item|
        item = cart_item.item
        OrderDetail.create!(
          order_id: id,
          item_id: item.id,
          price: item.with_tax_price,
          amount: cart_item.amount
        )
      end
      cart_items.destroy_all
    end
  end
  
  def get_shipping_informations_from(resource)
    class_name = resource.class.name
    if class_name == 'Customer' # resource: Customer
      self.postal_code = resource.postal_code
      self.destination = resource.address
      self.name = resource.full_name
    elsif class_name == 'Address' # resource: Address
      self.postal_code = resource.postal_code
      self.destination = resource.destination
      self.name = resource.name
    end
  end
end
