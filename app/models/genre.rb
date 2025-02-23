class Genre < ApplicationRecord
  has_many :items, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  scope :only_active, -> { where(is_active: true) }
end
