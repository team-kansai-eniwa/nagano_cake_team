class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order


  enum making_status: { unavailable: 0, pending: 1, in_progress: 2, completed: 3 }
end
