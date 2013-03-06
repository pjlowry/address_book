class Contact
  attr_reader :name, :id
  def initialize(name='', id='')
    @name = name
    @id = id
  end

  def add
    @id = DB.exec("INSERT INTO contacts (name) VALUES ('#{@name}') RETURNING id;").map {|result| result['id']}[0]
    #@id = DB.exec("SELECT id FROM contacts where name = '#{@name}'")[0]['id'] 
  end

  def edit(name) #needs a tiny bit of refactoring
      old_name = @name
      @name = name unless name.empty?
      DB.exec("UPDATE contacts SET name = '#{@name}' WHERE name = '#{old_name}';") #change WHERE to look for id
  end
  
  def self.list_names
    DB.exec("SELECT name FROM contacts").inject([]) { |names, contact_hash| names << Contact.new(contact_hash['name']) }
  end

  def self.find_by_name(name) #screwed up
    DB.exec("SELECT * FROM contacts WHERE contacts.name = '#{name}'").inject([]) { |matches, contact_hash| matches << Contact.new(contact_hash['name'], contact_hash['id']) }[0]
  end

  def ==(other)
    if other.class != Contact
      false
    else
      self.name == other.name 
    end
  end 

  def delete # should delete corresponding entries in other tables
      DB.exec("DELETE FROM contacts WHERE contacts.name = '#{@name}'")
  end



end