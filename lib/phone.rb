class Phone
  attr_reader :number, :type, :id
  def initialize(type='', number='',id=0)
    @id = id
    @type = type
    @number = number
  end

  def add
    DB.exec("INSERT INTO phone (type, number, id) VALUES ('#{@type}', '#{@number}',#{@id})")
  end

  def self.find_by_id(id)
    DB.exec("SELECT * FROM phone WHERE phone.id = #{id}").inject([]) { |matches, hash| matches << Phone.new(hash['type'], hash['number'], hash['id'].to_i) }
  end

  def self.find_by(column_name,value, id)
    DB.exec("SELECT * FROM phone WHERE phone.#{column_name} = '#{value}' AND phone.id = #{id}").inject([]) { |matches, hash| matches << Phone.new(hash['type'], hash['number'], hash['id'].to_i) }
  end

  def ==(other)
    if other.class != Phone
      false
    else
      self.type == other.type && self.number == other.number && self.id == other.id
    end
  end 

  def delete 
    DB.exec("DELETE FROM phone WHERE phone.id = '#{@id}'")
  end

  def edit(type='', number='', id=@id)
    @type = type unless type.empty?
    @number = number unless number.empty?
    DB.exec("UPDATE phone SET type = '#{@type}', number = '#{@number}' WHERE phone.id = #{@id} AND phone.type = '#{@type}';")
  end
end
