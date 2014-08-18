require 'Books'
# require 'patrons'
require 'pg'
require 'RSpec'
require 'author'

DB = PG.connect(:dbname => 'books_test')
RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM books *;")
    # DB.exec("DELETE FROM patrons *;")
    DB.exec("DELETE FROM authors *;")
  end
end
