class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_details

  has_one_attached :item_image

  scope :where_item_active, -> { where(is_active: true) }
  scope :where_genre_active, -> { joins(:genre).where(genres: { is_active: true }) }

  def get_item_image
    unless item_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.png')
      item_image.attach(io: File.open(file_path), filename: 'no_image.png', content_type: 'image/png')
    end
    item_image
  end

  def self.recommended
    where_item_active.where_genre_active.limit(5).to_a
  end
  
  def with_tax_price
    (price * 1.1).ceil
  end
end
