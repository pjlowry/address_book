require 'pg'
require './lib/contact'
require './lib/phone'
require './lib/email'
require './lib/address'


DB = PG.connect(:dbname => 'address_book')


def welcome
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
  contact = Contact.new('name')
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

  puts "Would you like to add another address? Press 'n' for no."
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

def delete
  puts "Who would you like to delete?"
  name = gets.chomp
  contact = Contact.find_by_name(name)
  contact.delete
  put "Deleted contact '#{contact.name}'"
end

def edit
  puts "Who would you like to edit?"
  find_name = gets.chomp
  contact = Contact.find_by_name(find_name)
  found_name = contact.name
  puts "Enter a name to change (or press enter to skip):"
  name = gets.chomp
  puts "Enter a phone number to change (or press enter to skip):"
  phone = gets.chomp
  puts "Enter a email address to change (or press enter to skip):"
  email = gets.chomp
  puts "Enter a mail address to change (or press enter to skip):"
  address = gets.chomp
  contact.edit(name,phone,email,address)
  puts "Edited contact '#{found_name}'"
end

def find #join table
  puts "Whose contact information would you like to see?"
  name = gets.chomp
  contact = Contact.find_by_name(name)
  if contact != nil
    puts "   Name: #{contact.name}"
    puts "   Phone: #{contact.phone}"
    puts "   Email: #{contact.email}"
    puts "   Mailing Address: #{contact.address}\n\n"
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