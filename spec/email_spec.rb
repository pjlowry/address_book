require 'spec_helper'

describe Email do 
  context 'add' do 
    it 'collects a email and type of email for a contact' do 
      Email.find_by_id(4444).should eq []
      contact = Contact.new('Bob')
      email = Email.new('work', 'bob@bob.com', 4444)
      email.add
      Email.find_by_id(4444).should eq [email]
      DB.exec("DELETE FROM email *;")
    end
  end

  context '#find_by_id' do 
    it 'finds a phone number and type by a contacts id number, returning an array of phone objects' do 
      email = Email.new('work', '843-333-4444',1111)
      email.add
      Email.find_by_id(1111).should eq [email]
      DB.exec("DELETE FROM email *;")
    end
  end

  context '#==' do
    it 'returns true if two email addresses contain the same type, email address, and id' do
      email1 = Email.new('work', 'john@john.com', 3333)
      email2 = Email.new('work', 'john@john.com', 3333)
      email1.should eq email2
      DB.exec("DELETE FROM email *;")
      # DB.exec("DELETE FROM phone *;")
    end
  end

  context '#delete' do
    it 'deletes a contacts email.' do
      email = Email.new('work','reallygreat@email.com', 2222)
      email.add
      email.delete
      Email.find_by_id(2222).should eq []
    end
  end

  context '#edit' do
    it 'edits a contact email number' do
      email = Email.new('home','mary@jane.com', 2222)
      email.add
      email2 = Email.new('home','mary.jane@gmail.com', 2222)
      email2.edit('','mary.jane@gmail.com',2222)
      Email.find_by_id(2222).should eq [email2]
      DB.exec("DELETE FROM email *;")
    end
  end
end
