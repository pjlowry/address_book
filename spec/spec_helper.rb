require 'rspec'
require 'pg'
require 'contact'
require 'phone'
require 'email'
require 'address'

DB = PG.connect(:dbname => 'address_book_test')

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM contacts *;")
    DB.exec("DELETE FROM phone *;")
    DB.exec("DELETE FROM email *;")
    DB.exec("DELETE FROM address *;")
  end
end