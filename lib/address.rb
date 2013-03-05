class Address
  attr_reader :street, :type, :city, :state, :zip, :id
  def initialize(type='', street='', city='', state='', zip='', id='')
    @id = id
    @type = type
    @street = street
    @city = city
    @state = state
    @zip = zip
  end

  def add
    DB.exec("INSERT INTO address (type, street, city, state, zip, id) VALUES ('#{@type}', '#{@street}', '#{@city}', '#{@state}', '#{@zip}', #{@id})")
  end

  def self.find_by_id(id)
    DB.exec("SELECT * FROM address WHERE address.id = #{id}").inject([]) { |matches, address_hash| matches << Address.new(address_hash['type'], address_hash['street'], address_hash['city'], address_hash['state'], address_hash['zip'], address_hash['id'].to_i) }
  end

  def ==(other)
    if other.class != Address
      false
    else
      self.type == other.type && self.street == other.street && self.city == other.city && self.state == other.state && self.zip == other.zip && self.id == other.id
    end
  end 

  def delete 
    DB.exec("DELETE FROM address WHERE address.id = '#{@id}'")
  end

end