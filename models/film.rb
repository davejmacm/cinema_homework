require_relative('../db/sql_runner')

class Film

  attr_reader :id
  attr_accessor :title, :price

 def initialize(options)
   @id = options['id'].to_i if options['id']
   @title = options['title']
   @price = options['price']
 end


# CRUD methods
VARa = "films"
VARb = "title"
VARc = "price"
d = "film"

def save()
   sql = "INSERT INTO #{VARa}(
         #{VARb},
         #{VARc}
         )
         VALUES ($1, $2)
         RETURNING id"
  values = [@title, @price]
  d = SqlRunner.run(sql, values).first
  @id = d ['id'].to_i
 end

 def self.delete_all()
   sql = "DELETE FROM #{VARa}"
   SqlRunner.run(sql)
 end

 def delete()
   sql = "DELETE FROM #{VARa}
         WHERE id = $1"
   values = [@id]
   SqlRunner.run(sql, values)
 end

 def self.all()
   sql = "SELECT * FROM #{VARa}"
   d = SqlRunner.run(sql)
   return d.map {|film| Film.new (d)}
 end

 def update()
   sql = "UPDATE #{VARa}
   SET(
     #{VARb}, #{VARc}
     )
     =
     ($1, $2)
     WHERE id = $3"
     values = [@title, @price, @id]
     SqlRunner.run(sql, values)
 end

# end of crud functionality; below is lookup methods

def customers()
  sql = "SELECT customers.name
        FROM customers
        INNER JOIN tickets
          ON tickets.customer_id = customers.id
        WHERE tickets.film_id = $1"
  values = [@id]
  customers = SqlRunner.run(sql, values)
  return customers.map{|customer| Customer.new(customer)}
end





end
