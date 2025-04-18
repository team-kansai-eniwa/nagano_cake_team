class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :genre

  validates :name, :introduction, :genre_id, :price, presence: true
  validates :is_active, inclusion: { in: [true, false] }
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :image, presence: true

  def active_status_label
    is_active ? "販売中" : "販売停止中"
  end
end
