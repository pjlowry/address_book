require 'spec_helper'

describe Address do 
  context 'add' do 
    it 'collects a address and type of address for a contact' do 
      Address.find_by_id(4444).should eq []
      contact = Contact.new('Bob')
      address = Address.new('work', '1 2nd st', 'folsom', 'CA','92343',4444)
      address.add
      Address.find_by_id(4444).should eq [address]
    end
  end

  context '#find_by_id' do 
    it 'finds a phone number and type by a contacts id number, returning an array of phone objects' do 
      address = Address.new('home', '10 infinite loop', 'cupertino', 'CA', '92092',1111)
      address.add
      Address.find_by_id(1111).should eq [address]
    end
  end

  context '#find_by_id' do 
    it 'finds a phone number and type by a contacts id number, returning an array of phone objects' do 
      address = Address.new('home', '10 infinite loop', 'cupertino', 'CA', '92092',1111)
      address.add
      Address.find_by('type','home',1111).should eq [address]
    end
  end

  context '#==' do
    it 'returns true if two Address addresses contain the same type, Address address, and id' do
      address1 = Address.new('work', '999 something blvd.', 'elsewhere', 'NV', '91111', 3333)
      address2 = Address.new('work', '999 something blvd.', 'elsewhere', 'NV', '91111', 3333)
      address1.should eq address2
    end
  end

  context '#delete' do
    it 'deletes a contacts address (street, city, state, zip).' do
      address = Address.new('home','999 something blvd.', 'elsewhere', 'NV', '91111', 3333)
      address.add
      address.delete
      Address.find_by_id(2222).should eq []
    end
  end

  context '#edit' do
    it 'edits a contacts address' do
      address1 = Address.new('work', '999 something blvd.', 'elsewhere', 'NV', '91111', 3333)
      address2 = Address.new('work', '123 4th st.', 'hereville', 'NV', '91111', 3333)
      address1.add
      address2.edit('', '123 4th st.', 'hereville')
      Address.find_by_id(3333).should eq [address2]
    end
  end
end
