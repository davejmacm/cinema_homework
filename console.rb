require_relative('models/ticket.rb')
require_relative('models/film.rb')
require_relative('models/customer.rb')

require('pry-byebug')

customer1 = Customer.new ({
  'name' => 'Dave',
  'funds' => '12.50'
  })

customer1.save()

film1 = Film.new ({
  'title' => 'Lord of the Rings',
  'price' => '7.00'
  })

film1.save()

ticket1 = Ticket.new ({
  'customer_id' => customer1.id,
  'film_id' => film1.id
  })

ticket1.save()

binding.pry
nil
