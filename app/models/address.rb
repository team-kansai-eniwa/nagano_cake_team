class Address < ApplicationRecord
  belongs_to :customer

  validates :name, :postal_code, :address, presence: true
  def address_display
    '〒' + self.postal_code + ' ' + self.address + ' ' + self.name
  end
end
