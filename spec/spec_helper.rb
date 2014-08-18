require 'Books'
# require 'patrons'
require 'pg'
require 'RSpec'

DB = PG.connect(:dbname => 'books_test')
RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM books *;")
    # DB.exec("DELETE FROM patrons *;")
  end
end
