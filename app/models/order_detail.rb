class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order


  enum making_status: { unavailable: 0, pending: 1, in_progress: 2, completed: 3 }, _prefix: true

  after_update :update_order_status_if_needed
  after_update :update_order_status_if_all_completed

  private

  # 1つでも制作ステータスを製作中にする⇒注文ステータスを製作中にする
  def update_order_status_if_needed
    if making_status == "in_progress"
      unless order.status == "producting"
        order.update(status: "producting")
      end
    end
  end

  # 全ての製作ステータスを製作完了にする⇒注文ステータスを発送済みにする
  def update_order_status_if_all_completed
    if self.making_status == "completed"
      if order.order_details.all? { |detail| detail.making_status == "completed" }
        order.update(status: "preparing")
      end
    end
  end
end
