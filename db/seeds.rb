# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 商品データの作成（ジャンルも必要なので先にジャンル作成）
3.times do |i|
  Customer.find_or_create_by!(email: "customer#{i + 1}@example.com") do |customer|
    customer.password = "password#{i + 1}"
    customer.last_name = "姓#{i + 1}"
    customer.first_name = "名#{i + 1}"
    customer.last_name_kana = "セイ#{i + 1}"
    customer.first_name_kana = "メイ#{i + 1}"
    customer.postal_code = "123456#{i}"
    customer.address = "東京都サンプル区#{i + 1}-番地"
    customer.telephone_number = "0901234567#{i}"
    customer.is_active = true
  end
end

genre = Genre.find_or_create_by!(name: "ジャンル1")

3.times do |i|
  Item.create!(
    genre_id: genre.id,
    name: "商品#{i + 1}",
    introduction: "これは商品#{i + 1}の説明です。",
    price: (100 + i * 50),
    is_active: true
  )
end

customers = Customer.limit(3)
items = Item.limit(3)

3.times do |i|
  CartItem.create!(
    customer: customers[i],
    item: items[i],
    amount: (i + 1) * 2  # 2, 4, 6 の数量
  )
end

orders = Order.create!([
  {
    customer_id: 1,
    postal_code: "1234567",
    address: "東京都新宿区1-1-1",
    name: "山田太郎",
    shipping_cost: 800,
    total_payment: 4300,
    payment_method: 0, # クレジットカード
    status: 0,
    created_at: Time.current,
    updated_at: Time.current
  },
  {
    customer_id: 2,
    postal_code: "7654321",
    address: "大阪府大阪市中央区2-2-2",
    name: "佐藤花子",
    shipping_cost: 800,
    total_payment: 2900,
    payment_method: 1, # 銀行振込
    status: 0,
    created_at: Time.current,
    updated_at: Time.current
  },
  {
    customer_id: 3,
    postal_code: "9876543",
    address: "北海道札幌市3-3-3",
    name: "鈴木次郎",
    shipping_cost: 800,
    total_payment: 5100,
    payment_method: 0,
    status: 0,
    created_at: Time.current,
    updated_at: Time.current
  }
])

# 注文詳細（order_details）
OrderDetail.create!([
  {
    order_id: orders[0].id,
    item_id: 1,
    price: 1500,
    amount: 2,
    making_status: 0,
    created_at: Time.current,
    updated_at: Time.current
  },
  {
    order_id: orders[1].id,
    item_id: 2,
    price: 1300,
    amount: 1,
    making_status: 0,
    created_at: Time.current,
    updated_at: Time.current
  },
  {
    order_id: orders[2].id,
    item_id: 3,
    price: 2150,
    amount: 2,
    making_status: 0,
    created_at: Time.current,
    updated_at: Time.current
  }
])

Address.create([
  { customer_id: 1, name: 'Home', postal_code: '123-4567', address: 'Tokyo, Japan', created_at: '2025-04-18 00:00:00', updated_at: '2025-04-18 00:00:00' },
  { customer_id: 2, name: 'Work', postal_code: '987-6543', address: 'Osaka, Japan', created_at: '2025-04-18 00:00:00', updated_at: '2025-04-18 00:00:00' }
])
