require 'pg'
require './lib/contact'

DB = PG.connect(:dbname => 'address_book')


def welcome
  puts "Welcome to the Address Book!"
  menu
end

def menu
  choice = nil
  until choice == 'e'
    puts "Press 'a' to add a contact, 'l' to list your contacts, or 'd' to delete a contact, or 'e' to edit a contact."
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
  Contact.list_names.each { |name| puts name }
end

def delete
end

def edit
end

def exit
end



welcome