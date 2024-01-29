# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

require 'audited'

admin = Admin.create(email: 'test@test.com', password: '123123', password_confirmation: '123123')
admin2 = Admin.create(email: 'tes2@test.com', password: '123123', password_confirmation: '123123')

Audited.audit_class.as_user(admin) do
  attributes = { first_name: 'test', last_name: 'test', id_number: 123_123 }
  customer = Customer.new()
  attributes.each do |key, value|
    customer.send("#{key}=", value)
  end
  customer.save

  category = Category.new()
  category.name = 'transportation'
  category.save

  category2 = Category.new()
  category2.name = 'food'
  category2.save

  category3 = Category.new()
  category3.name = 'electronics'

  def assign_product(product, attributes, category)
    attributes.each do |key, value|
      product.send("#{key}=", value)
    end
    product.categories << category
    product.save
  end

  product = Product.new
  attributes = { name: 'mazda 323', description: 'mazda', type: 'car', price: 400.0 }
  assign_product(product, attributes, category)

  product2 = Product.new
  attributes = { name: 'apple', description: 'delicious', type: 'fuits', price: 1 }
  assign_product(product2, attributes, category2)

  product3 = Product.new
  attributes = { name: 'audi 323', description: 'audi', type: 'car', price: 100_000.0 }
  assign_product(product3, attributes, category)

  product4 = Product.new
  attributes = { name: 'iphone', description: 'iphone 15', type: 'mobile', price: 1_000.0 }
  assign_product(product4, attributes, category3)

  product5 = Product.new
  attributes = { name: 'Samsung', description: 'A 15', type: 'mobile', price: 100.0 }
  assign_product(product5, attributes, category3)

  product6 = Product.new
  attributes = { name: 'Xioami', description: 'X15', type: 'mobile', price: 100.0 }
  assign_product(product6, attributes, category3)

  product7 = Product.new
  attributes = { name: 'orange', description: 'yummy', type: 'fuits', price: 1 }
  assign_product(product7, attributes, category2)

  product8 = Product.new
  attributes = { name: 'F12', description: 'Ferrari', type: 'car', price: 300.0 }
  assign_product(product8, attributes, category)

  photo =  Photo.new(name: 'image', image: 'image')
  photo.photoable_id = product.id
  photo.photoable_type = 'Product'
  photo.save

  def assign_purchase(purchase, attributes)
    attributes.each do |key, value|
      purchase.send("#{key}=", value)
    end
  end

  attrs = [
    { customer: customer, product: product, quantity: 3 },
    { customer: customer, product: product2, quantity: 1 },
    { customer: customer, product: product3, quantity: 1 },
    { customer: customer, product: product3, quantity: 4 },
    { customer: customer, product: product4, quantity: 2 },
    { customer: customer, product: product5, quantity: 2 },
    { customer: customer, product: product6, quantity: 5 },
    { customer: customer, product: product7, quantity: 8 },
    { customer: customer, product: product8, quantity: 3 },
  ]
  attrs.each do |attr|
    purchase = Purchase.new
    assign_purchase(purchase, attr)
    PurchaseProcessor.new(purchase, admin).call
  end
end

admin = Admin.first
customer = Customer.first
product = Product.first
purchase = Purchase.new
purchase.customer = customer
purchase.product = product
purchase.quantity = 1
PurchaseProcessor.new(purchase, admin).call

