require_relative('../db/sql_runner')

class Customer

  attr_reader :id
  attr_accessor :name, :funds

 def initialize(options)
   @id = options['id'].to_i if options['id']
   @name = options['name']
   @funds = options['funds']
 end


# CRUD methods
@@a = "customers"
@@b = "name"
@@c = "funds"
@@d = "customer"

def save()
   sql = "INSERT INTO #{@@a}(
         #{@@b},
         #{@@c}
         )
         VALUES ($1, $2)
         RETURNING id"
  values = [@name, @funds]
  @@d = SqlRunner.run(sql, values).first
  @id = @@d ['id'].to_i
 end

 def self.delete_all()
   sql = "DELETE FROM #{@@a}"
   SqlRunner.run(sql)
 end

 def delete()
   sql = "DELETE FROM #{@@a}
         WHERE id = $1"
   values = [@id]
   SqlRunner.run(sql, values)
 end

 def self.all()
   sql = "SELECT * FROM #{@@a}"
   d = SqlRunner.run(sql)
   return d.map {|customer| Customer.new (@@d)}
 end

 def update()
   sql = "UPDATE #{@@a}
   SET(
     #{@@b}, #{@@c}
     )
     =
     ($1, $2)
     WHERE id = $3"
     values = [@name, @funds, @id]
     SqlRunner.run(sql, values)
 end

# end of crud functionality; below is lookup methods

 def films()
   sql = "SELECT films.title
         FROM films
         INNER JOIN tickets
           ON tickets.film_id = films.id
         WHERE tickets.customer_id = $1"
   values = [@id]
   films = SqlRunner.run(sql, values)
   return films.map{|film| Film.new(film)}
 end

 def tickets()
  sql = "SELECT customers.name, count(tickets.customer_id) as number_of_tickets
        FROM customers
        LEFT JOIN tickets
           on (customers.id = tickets.customer_id)
        WHERE customers.id = $1
        GROUP BY
        	customers.id
           "
  values = [@id]
  tickets = SqlRunner.run(sql, values)
  return tickets.map{|ticket| Ticket.new(tickets)}
 end

end
