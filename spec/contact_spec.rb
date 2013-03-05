require 'spec_helper'

 describe Contact do
#   context '#initialize' do
#     it 'initializes an instance, taking the contact name, phone number, email and mailing address as arguments' do 
#       contact = Contact.new('Peter', '312-450-4610', 'plowry812@gmail.com', '1200 NW Marshall #809, Portland, OR 97209')
#       contact.should be_an_instance_of Contact
#     end
#   end

#   context 'public instance variables' do
#     it 'allows access to name, phone number, email, and address' do
#       contact = Contact.new('Peter', '312-450-4610', 'plowry812@gmail.com', '1200 NW Marshall #809, Portland, OR 97209')
#       contact.name.should eq 'Peter'
#       contact.phone.should eq '312-450-4610'
#       contact.email.should eq 'plowry812@gmail.com'
#       contact.address.should eq '1200 NW Marshall #809, Portland, OR 97209'
#     end 
#   end

  
  context '#add' do
    it 'adds contacts to my address book, so that I can store my contacts in one place.' do
      Contact.find_by_name('George').should eq nil
      contact = Contact.new('George')
      contact.add
      Contact.find_by_name('George').should eq contact
      DB.exec("DELETE FROM contacts *;")
    end

    it 'retrieves the auto-id from the database and applies to the object.' do
      # DB.should_receive(:exec).with("INSERT INTO contacts (name, phone, email, address) VALUES ('George', '916-357-1392', 'notreally@myemail.com', '1724 H St., Sacramento, CA 95811')")
      contact = Contact.new('Josefus')
      contact.add
      id = DB.exec("SELECT id FROM contacts where name = 'Josefus'").inject([]) { |matches, contact_hash| matches << contact_hash['id'] }[0]
      contact.id.should eq id
    end
  end

  context '.find_by_name' do
    it 'displays a contact and all of their contact information.' do
      contact1 = Contact.new('George')
      contact1.add
      contact2 = Contact.find_by_name('George')
      contact2.should eq contact1 
      DB.exec("DELETE FROM contacts *;")
    end
  end

  context '.list_names' do
      it 'lists all the names in my contacts' do
      names = ['Bob', 'George']
      names.each { |list_name| Contact.new(list_name).add}
      Contact.list_names.map { |contact| contact.name }.should =~ names
      DB.exec("DELETE FROM contacts *;")
    end
  end


  context '#==' do
    it 'returns true if two contacts contain the same name, phone number, email, and mailing address' do
      contact1 = Contact.new('George')
      contact2 =  Contact.new('George')
      contact1.should eq contact2
      DB.exec("DELETE FROM contacts *;")
    end
  end

  context '#edit' do
    it 'edits a contact, so that I can update their information if it changes.' do
      contact = Contact.new('George')
      contact.add
      contact2 = Contact.new('George')
      contact2.edit('Georgino')
      Contact.find_by_name('Georgino').should eq contact2
      DB.exec("DELETE FROM contacts *;")
    end
  end

  context '#delete' do
    it 'deletes a contact.' do
      contact = Contact.new('George')
      contact.add
      contact.delete
      Contact.find_by_name('George').should eq nil
    end
  end

end