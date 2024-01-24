# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

customer = Customer.create(first_name: 'test', last_name: 'test', id_number: 123123)
category = Category.create(name: 'transportation')
product = Product.create(name: 'mazda 323', description: 'mazda', type: 'car', price: 400.000, categories: [category])
photo =  Photo.new(name: 'image', image: 'image')
photo.photoable_id = product.id
photo.photoable_type = 'Product'
photo.save
purchase = Purchase.create(customer: customer, product: product, quantity: 3)
admin = Admin.create(email: 'test@test.com', password: '123123', password_confirmation: '123123')
