class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details
  has_many :items, through: :order_details

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { waiting: 0, paid_up: 1, producting: 2, preparing: 3, sented: 4 }

  validates :name, :postal_code, :address, presence: true

  def total_payment
    order_details.sum { |detail| detail.item.price * detail.amount }
  end

  after_update :update_order_detail_status_if_needed

  private

  def update_order_detail_status_if_needed
    if saved_change_to_status? && status == "paid_up"
      self.order_details.update_all(making_status: "pending")
    end
  end
end
