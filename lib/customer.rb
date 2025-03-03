require "csv"

class Customer
  attr_accessor :email, :address
  attr_reader :id
  
  def initialize(id, email, address)
    @id = id.to_i
    @email = email
    @address = address 
  end
  
  def self.all
    all_customers = []
    
    CSV.foreach("data/customers.csv") do |row|    
      all_customers << Customer.new(row[0], row[1], {street: row[2], city: row[3], state: row[4], zip: row[5]})
    end
    
    return all_customers
  end
  
  def self.find(id)
    customer = Customer.all.find do |customer|
      customer.id == id
    end
    
    return customer
  end
  
  def self.save(filename)
    all_customers = Customer.all
    
    CSV.open(filename, "w") do |csv|
      all_customers.each do |customer|
        csv << [customer.id, customer.email, customer.address[:street], customer.address[:city], customer.address[:state], customer.address[:zip]]
      end
    end    
  end
end
