require 'rspec'
require 'pg'
require 'contact'

DB = PG.connect(:dbname => 'address_book_test')

RSpec.configure do |config|
  config.after(:all) do
    DB.exec("DELETE FROM contacts *;")
  end
end