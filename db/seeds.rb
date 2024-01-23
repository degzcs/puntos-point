# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

customer = Customer.create(first_name: 'test', last_name: 'test', id_number: 123123)
category = Category.create(name: 'transportation')
product = Product.create(name: 'mazda 323', description: 'mazda', type: 'car', price: 400.000, categories: [category])
purchase = Purchase.create(customer: customer, product: product, quantity: 3)
