class Contact
  attr_reader :name, :phone, :email, :address
  def initialize(name='notempty', phone='notempty', email='notempty', address='notempty')
    @name = name
    @phone = phone
    @email = email
    @address = address
  end

  def add
    DB.exec("INSERT INTO contacts (name, phone, email, address) VALUES ('#{@name}', '#{@phone}', '#{@email}', '#{@address}')")
  end


  def edit(name,phone='',email='',address='')
      old_name = @name
      @name = name unless name.empty?
      @phone = phone unless phone.empty?
      @email = email unless email.empty?
      @address = address unless address.empty?
      DB.exec("UPDATE contacts SET name = '#{@name}', phone = '#{@phone}', email = '#{@email}', address = '#{@address}' WHERE name = '#{old_name}';")
  end
  
  def self.list_names
    DB.exec("SELECT name FROM contacts").inject([]) { |names, contact_hash| names << Contact.new(contact_hash['name']) }
  end

  def self.find_by_name(name)
    DB.exec("SELECT * FROM contacts WHERE contacts.name = '#{name}'").inject([]) { |matches, contact_hash| matches << Contact.new(contact_hash['name'], contact_hash['phone'], contact_hash['email'], contact_hash['address']) }[0]
  end

  def ==(other)
    self.name == other.name && self.phone == other.phone && self.email == other.email && self.address == other.address
  end 

  def delete
      DB.exec("DELETE FROM contacts WHERE contacts.name = '#{@name}'")
  end



end