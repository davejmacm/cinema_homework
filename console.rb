require_relative('models/ticket.rb')
require_relative('models/film.rb')
require_relative('models/customer.rb')

require('pry-byebug')

# testing delete.all methods

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

# adding records to customers table --- tests save method

customer1 = Customer.new ({
  'name' => 'Dave',
  'funds' => '12.50'
  })

customer1.save()

customer2 = Customer.new ({
  'name' => 'Andy',
  'funds' => '25.00'
  })

customer2.save()

customer3 = Customer.new ({
  'name' => 'Bob',
  'funds' => '8.75'
  })

customer3.save()

# adding records to films table --- tests save method

film1 = Film.new ({
  'title' => 'Lord of the Rings',
  'price' => '7.00'
  })

film1.save()

# tests update method

film1.title = "Lord of the Rings The Fellowship of the Ring"
film1.update()

film2 = Film.new ({
  'title' => 'Big Hero 6',
  'price' => '3.75'
  })

film2.save()

film3 = Film.new ({
  'title' => 'Rurouni Kenshin',
  'price' => '6.15'
  })

film3.save()

# adding records to tickets table --- tests save method

ticket1 = Ticket.new ({
  'customer_id' => customer1.id,
  'film_id' => film1.id
  })

ticket1.save()

ticket2 = Ticket.new ({
  'customer_id' => customer1.id,
  'film_id' => film3.id
  })

ticket2.save()

ticket3 = Ticket.new ({
  'customer_id' => customer2.id,
  'film_id' => film1.id
  })

ticket3.save()

ticket4 = Ticket.new ({
  'customer_id' => customer3.id,
  'film_id' => film2.id
  })

ticket4.save()



binding.pry
nil
