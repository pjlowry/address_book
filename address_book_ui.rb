require 'pg'
require './lib/contact'
require './lib/phone'
require './lib/email'
require './lib/address'


DB = PG.connect(:dbname => 'address_book')

def welcome
#  contact = Contact.find_by_name('John')
 # puts Phone.find_by('type','cell',contact.id)
  #list_by(Phone,'type','cell','number',contact.id)
  puts "Welcome to the Address Book!"
  menu
end

def menu
  choice = nil
  until choice == 'x'
    puts "Press 'a' to add a contact, 'l' to list your contacts, or 'd' to delete a contact, or 'e' to edit a contact or 'f' to find by name."
    puts "Press 'x' to exit."
    choice = gets.chomp
    case choice
    when 'a'
      add
    when 'l'
      list
    when 'd'
      delete
    when 'e'
      edit
    when 'f'
      find
    when 'x'
      exit
    else 
      invalid
    end
  end
end

def add
  puts "Please enter your contact's name:"
  name = gets.chomp
  contact = Contact.new(name)
  contact.add
  number_array = ask_for_multiple('phone number',['work','cell','home'])
  number_array.each do |info_array| 
    phone = Phone.new(info_array[0],info_array[1], contact.id) 
    phone.add
    puts "Phone number added: #{info_array[0]} #{info_array[1]}"
  end
  email_array = ask_for_multiple('email',['work','home'])
  email_array.each do |info_array| 
    email = Email.new(info_array[0],info_array[1], contact.id) 
    email.add
    puts "Email added: #{info_array[0]} #{info_array[1]}"
  end
  add_address(contact)
end

def add_address(contact)
  puts "Please enter a type of address, home or work:"
  type = gets.chomp
  puts "Please enter your contact's street and apartment number:"
  street = gets.chomp
  puts "Please enter your contact's city:"
  city = gets.chomp
  puts "Please enter your contact's state:"
  state = gets.chomp
  puts "Please enter your contact's zip code:"
  zip = gets.chomp
  address = Address.new(type, street, city, state, zip, contact.id)
  address.add
  puts "Address added: #{street}, #{city}, #{state}, #{zip} (#{type})"

  puts "Would you like to add another address? Press 'n' for no or any other key for yes."
  unless gets.chomp == 'n'
    add_address(contact)
  end
end


def ask_for_multiple(whatever,options,array=[]) 
  mini_array = []
  puts "What type of #{whatever} do you want to add?: #{options.join(', ')}"
  mini_array << gets.chomp
  puts "Please enter your #{whatever}."
  mini_array << gets.chomp
  array << mini_array
  puts "Would you like to enter another? (type 'y' for yes, anything else for no.)"
  if gets.chomp == 'y'
    ask_for_multiple(whatever,options,array)
  end
  array
end


def list
  puts "Here is a list of all your contacts:"
  Contact.list_names.each { |contact| puts "   " + contact.name }
end

def list_by(class_name,column_name,value,return_column_array,id)
  class_name.find_by(column_name,value,id).each do |instance| 
    instance_variable_array = return_column_array.inject([]) { |array, return_column| array << instance.send(return_column) }
    puts "   " + instance_variable_array.join(' ')
  end
end

def delete
  puts "Who would you like to delete?"
  name = gets.chomp
  contact = Contact.find_by_name(name)
  if contact != nil
    contact.delete 
    puts "Deleted contact '#{contact.name}'"
  else
    puts "Contact not found."
  end
end

def edit
  list
  puts "Which contact would you like to edit?"
  find_name = gets.chomp
  contact = Contact.find_by_name(find_name)
  found_name = contact.name
  puts "Now editing #{contact.name}." #include all contacts info
  edit_submenu(contact)
end


def edit_submenu(contact)
  choice = nil
  until choice == '5'
    puts "Choose from the following options:"
    puts "   1. Edit the contacts name."
    puts "   2. Edit the contacts phone numbers."
    puts "   3. Edit the contacts email addresses."
    puts "   4. Edit the contacts mailing addresses."
    puts "   5. Exit the editor."
    choice = gets.chomp
    case choice 
    when '1'
      edit_name(contact)
    when '2'
      edit_number(contact)
    when '3'
      edit_email(contact)
    when '4'
      edit_address(contact)
    else
      invalid
    end
  end  
end

def edit_name(contact)
  puts "Please enter a new name for your contact.' (or press enter to go back):"  
  new_name = gets.chomp
  contact.edit(new_name) unless new_name == ''
end

def edit_number(contact)
  list_by(Phone,'id',contact.id,['type','number'],contact.id)
  puts "Enter a type of phone number to change: work, cell or home? (or press enter to skip):"
  type = gets.chomp
  if type != ''
    phone = Phone.find_by('type',type,contact.id)[0]
    puts "Enter the new number:"
    number = gets.chomp
    phone.edit(type, number, contact.id)
    puts "#{phone.number} has been added."
  end
end

def edit_email(contact)
  list_by(Email, 'id', contact.id,['type','email'], contact.id)
  puts "Enter the type of email address to change: work or home? (or press enter to skip):"
  type = gets.chomp
  if type != ''
    email = Email.find_by('type',type,contact.id)[0]
    puts "Enter the new email address:"
    email_address = gets.chomp
    email.edit(type, email_address, contact.id)
    puts "#{email.email} has been added."
  end
end

def edit_address(contact)
  list_by(Address, 'id', contact.id,['type', 'street','city','state','zip'] ,contact.id )
  puts "Enter the type of mailing address to change: work or home? (or press enter to skip):"
  type = gets.chomp
  if type != ''
    address = Address.find_by('type',type,contact.id)[0]
    puts "Enter the new street address:"
    street = gets.chomp
    puts "Enter the new city:"
    city = gets.chomp
    puts "Enter the new state:"
    state = gets.chomp
    puts "Enter the new zip code:"
    zip = gets.chomp
    address.edit(type, street, city, state, zip, contact.id)
    output_address = [street,city,state,zip].join(', ')
    puts "#{output_address} has been added."
  end
end

def find #join table
  puts "Whose contact information would you like to see?"
  name = gets.chomp
  contact = Contact.find_by_name(name)
  if contact != nil
    puts "   Name: #{contact.name}"
    # puts "   Phone: #{contact.phone}"
    # puts "   Email: #{contact.email}"
    # puts "   Mailing Address: #{contact.address}\n\n"
  else
    puts "Name not found."
  end 
end

def exit
  puts "Goodbye."
end

def invalid
  puts "Invalid entry."
end

welcome