class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order


  enum making_status: { unavailable: 0, pending: 1, in_progress: 2, completed: 3 }, _prefix: true

  after_update :order_status_if_all_completed

  private
  def order_status_if_all_completed
    if self.making_status == "completed"
      if order.order_details.all? { |detail| detail.making_status == "completed" }
        order.update(status: "preparing")
      end
    end
  end
end
