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
    DB.exec("SELECT * FROM address WHERE address.id = #{id}").inject([]) { |matches, hash| matches << Address.new(hash['type'], hash['street'], hash['city'], hash['state'], hash['zip'], hash['id'].to_i) }
  end

  def self.find_by(column_name,value, id)
    DB.exec("SELECT * FROM address WHERE address.#{column_name} = '#{value}' AND address.id = #{id}").inject([]) { |matches, hash| matches << Address.new(hash['type'], hash['street'], hash['city'], hash['state'], hash['zip'], hash['id'].to_i) }
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

  def edit(type='', street='',city='',state='',zip='', id=@id)
    @type = type unless type.empty?
    @street = street unless street.empty?
    @city = city unless city.empty?
    @state = state unless state.empty?
    @zip = zip unless zip.empty?
    DB.exec("UPDATE address SET type = '#{@type}', street = '#{@street}', city = '#{@city}', state = '#{@state}', zip = '#{@zip}' WHERE address.id = #{@id} AND address.type = '#{@type}';")
  end

end