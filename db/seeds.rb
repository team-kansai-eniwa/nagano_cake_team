# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者
Admin.create!(
  email: "admin@example.com",
  password: "password"
)

# 顧客3人
3.times do |i|
  Customer.create!(
    email: "customer#{i + 1}@example.com",
    password: "password",
    last_name: "姓#{i + 1}",
    first_name: "名#{i + 1}",
    last_name_kana: "セイ#{i + 1}",
    first_name_kana: "メイ#{i + 1}",
    postal_code: "123456#{i}",
    address: "東京都サンプル区#{i + 1}-番地",
    telephone_number: "0901234567#{i}"
  )
end

# 配送先（3つ）
Customer.all.each do |customer|
  Address.create!(
    customer_id: customer.id,
    name: "#{customer.last_name} #{customer.first_name}",
    postal_code: customer.postal_code,
    address: customer.address
  )
end

# ジャンル4つ
4.times do |i|
  Genre.create!(name: "ジャンル#{i + 1}")
end

# Genre.create!([
#   { name: 'ケーキ' },
#   { name: 'キャンディ' },
#   { name: '焼き菓子' },
#   { name: 'プリン' }
# ])