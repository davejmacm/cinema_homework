require_relative('../db/sql_runner')

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

 def initialize(options)
   @id = options['id'].to_i if options['id']
   @param_1 = options['customer_id']
   @param_2 = options['film_id']
 end


# CRUD methods
VARa = "tickets"
VARb = "customer_id"
VARc = "film_id"
d = "ticket"

def save()
   sql = "INSERT INTO #{VARa}(
         #{VARb},
         #{VARc}
         )
         VALUES ($1, $2)
         RETURNING id"
  values = [@param_1, @param_2]
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
   return d.map {|ticket| Ticket.new (d)}
 end

 def update()
   sql = "UPDATE #{VARa}
   SET(
     #{VARb}, #{VARc}
     )
     =
     ($1, $2)
     WHERE id = $3"
     values = [@param_1, @param_2, @id]
     SqlRunner.run(sql, values)
 end

 # end of crud functionality; below is lookup methods

def cost()
  sql = "UPDATE customers
  SET funds = (SELECT customers.funds - films.price AS " "cost""
        FROM customers
        INNER JOIN tickets
          ON tickets.customer_id = customers.id
        INNER JOIN films
          ON tickets.film_id = films.id
		WHERE tickets.id = $1)
    WHERE customers.id = $1"
    values = [@id]
    SqlRunner.run(sql, values)


    # cost = SqlRunner.run(sql,values)
    # # cannot get the value out of the hash
    # cost_array  = []
    # cost.each {|ticket| cost_array << ticket ["cost"].to_i}
    # p cost
    # sql = "UPDATE customers
    # SET funds = #{cost}
    # WHERE tickets.customer_id = customers.id"
    # SqlRunner.run(sql)

end



end
