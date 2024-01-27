# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

customer = Customer.create(first_name: 'test', last_name: 'test', id_number: 123123)

category = Category.create(name: 'transportation')
category2 = Category.create(name: 'food')
category3 = Category.create(name: 'electronics')

product = Product.create(name: 'mazda 323', description: 'mazda', type: 'car', price: 400.0, categories: [category])
product2 = Product.create(name: 'apple', description: 'delicious', type: 'fuits', price: 1, categories: [category2])
product3 = Product.create(name: 'audi 323', description: 'audi', type: 'car', price: 100_000.0, categories: [category])
product4 = Product.create(name: 'iphone', description: 'iphone 15', type: 'mobile', price: 1_000.0, categories: [category3])
product5 = Product.create(name: 'Samsung', description: 'A 15', type: 'mobile', price: 100.0, categories: [category3])

photo =  Photo.new(name: 'image', image: 'image')
photo.photoable_id = product.id
photo.photoable_type = 'Product'
photo.save

purchase = Purchase.create(customer: customer, product: product, quantity: 3)
purchase2 = Purchase.create(customer: customer, product: product2, quantity: 1)
purchase3 = Purchase.create(customer: customer, product: product3, quantity: 1)
purchase4 = Purchase.create(customer: customer, product: product3, quantity: 4)
purchase5 = Purchase.create(customer: customer, product: product4, quantity: 2)
purchase6 = Purchase.create(customer: customer, product: product5, quantity: 2)

admin = Admin.create(email: 'test@test.com', password: '123123', password_confirmation: '123123')
