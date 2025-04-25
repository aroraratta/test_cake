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
end
