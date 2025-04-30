class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items
  has_many :orders
  has_many :addresses

  validates :last_name, :first_name, :last_name_kana, :first_name_kana, :address, presence: true

  validates :postal_code, format: { with: /\A[0-9]+\z/ }
  validates :telephone_number, format: { with: /\A[0-9]+\z/ }

  def active_for_authentication?
    super && is_active == true
  end

end
