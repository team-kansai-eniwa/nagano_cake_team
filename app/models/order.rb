class Order < ApplicationRecord
  belongs_to :item
  has_many :order_details
end
