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
    DB.exec("SELECT * FROM email WHERE email.id = #{id}").inject([]) { |matches, email_hash| matches << Email.new(email_hash['type'], email_hash['email'], email_hash['id'].to_i) }
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


  def edit(type='', number='', id=0)
    old_type = @type
    @type = type unless type.empty?
    old_number = @number
    @number = number unless number.empty?
    DB.exec("UPDATE email SET type = '#{@type}', email = '#{@email}' WHERE email.id = '#{@id}';")
  end

end
