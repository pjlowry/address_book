require 'spec_helper'

describe Phone do 
  context 'add' do 
    it 'collects a phone number and type of number for a contact' do 
      Phone.find_by_id.should eq nil
      contact = Contact.new('Bob')
      number = Phone.new('cell', '999-432-4567', 4444)
      number.add.should eq number
      Number.find_by_id.should eq number
    end
  end

  context '#find_by_id' do 
    it 'finds a phone number and type by a contacts id number' do 
      number = Phone.new('work', '843-333-4444', 1111)
      number.add
      Number.find_by_id.should eq number
    end
  end
end

  

  #As a user, I want to store home, work, and cell phone numbers for my contacts, so that I can call them wherever they may be.

