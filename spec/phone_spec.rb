require 'spec_helper'

describe Phone do 
  context '#add' do 
    it 'collects a phone number and type of number for a contact' do 
      Phone.find_by_id(4444).should eq []
      contact = Contact.new('Bob')
      number = Phone.new('cell', '999-432-4567',4444)
      number.add
      Phone.find_by_id(4444).should eq [number]
    end
  end

  context '.find_by_id' do 
    it 'finds a phone number and type by a contacts id number, returning an array of phone objects' do 
      number = Phone.new('work', '843-333-4444',1111)
      number.add
      Phone.find_by_id(1111).should eq [number]
    end
  end

  context '.find_by' do 
    it 'finds a phone number and type by a contacts id number, returning an array of phone objects' do 
      number = Phone.new('work', '843-333-4444',1111)
      number.add
      Phone.find_by('type', 'work', 1111).should eq [number]
    end
  end

  context '#==' do
    it 'returns true if two phone numbers contain the same type, phone number, and id' do
      phone1 = Phone.new('cell', '939-333-3333', 3333)
      phone2 =  Phone.new('cell', '939-333-3333', 3333)
      phone1.should eq phone2
      
    end
  end

  context '#delete' do
    it 'deletes a contacts phone number.' do
      phone = Phone.new('cell','916-357-1392', 2222)
      phone.add
      phone.delete
      Phone.find_by_id(2222).should eq []
    end
  end


  context '#edit' do
    it 'edits a contact phone number' do
      phone = Phone.new('cell','916-357-1392', 2222)
      phone.add
      phone2 = Phone.new('work','916-357-1392', 2222)
      phone.edit('work',2222)
      Phone.find_by_id(2222).should eq [phone2]
    end
  end

end
  #As a user, I want to store home, work, and cell phone numbers for my contacts, so that I can call them wherever they may be.


