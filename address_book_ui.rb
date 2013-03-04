require 'pg'
require './lib/contact'

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
  puts "Please enter your name:"
  name = gets.chomp
  puts "Please enter your phone number:"
  phone = gets.chomp
  puts "Please enter your email:"
  email = gets.chomp
  puts "Please enter your mailing address:"
  address = gets.chomp
  contact = Contact.new(name, phone, email, address)
  contact.add
  puts "The following information has been added to your contacts:"
  puts "    " + name + ' ' + phone + ' ' + email + ' ' + address 
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

def find
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