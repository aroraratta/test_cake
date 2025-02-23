class Item < ApplicationRecord
  belongs_to :genre

  has_one_attached :item_image

  scope :where_genre_active, -> { joins(:genre).where(genres: { is_active: true }) }

  def get_item_image
    unless item_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.png')
      item_image.attach(io: File.open(file_path), filename: 'no_image.png', content_type: 'image/png')
    end
    item_image
  end
end
