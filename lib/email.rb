class Email
  attr_reader :email, :type, :id
  def initialize(type='', email='',id=0)
    @id = id
    @type = type
    @email = email
  end

  def add
    DB.exec("INSERT INTO email (type, email, id) VALUES ('#{@type}', '#{@email}',#{@id})")
  end

  def self.find_by_id(id)
    DB.exec("SELECT * FROM email WHERE email.id = #{id}").inject([]) { |matches, hash| matches << Email.new(hash['type'], hash['email'], hash['id'].to_i) }
  end

  def self.find_by(column_name,value, id)
    DB.exec("SELECT * FROM email WHERE email.#{column_name} = '#{value}' AND email.id = #{id}").inject([]) { |matches, hash| matches << Email.new(hash['type'], hash['email'], hash['id'].to_i) }
  end

  def ==(other)
    if other.class != Email
      false
    else
      self.type == other.type && self.email == other.email && self.id == other.id
    end
  end 

  def delete 
    DB.exec("DELETE FROM email WHERE email.id = '#{@id}'")
  end

  def edit(type='', email='', id=@id)
    @type = type unless type.empty?
    @email = email unless email.empty?    
    DB.exec("UPDATE email SET type = '#{@type}', email = '#{@email}' WHERE email.id = '#{@id} AND email.type = '#{@type}';")
  end
end
