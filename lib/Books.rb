require 'pry'

class Books
  attr_accessor :name, :author, :id

  def initialize(attributes)
    @name = attributes[:name]
    @author = attributes[:author]
    @id = attributes[:id].to_i
  end

  def self.all
    entire_selection = []
    results = DB.exec("SELECT * FROM books;")
    # binding.pry
    results.each do |result|
      name = result['name']
      author = result['author']
      id = result['id'].to_i
      entire_selection << Books.new({:name => name, :author => author, :id => id})
    end
    entire_selection
  end

  def self.delete(input_name)
    Books.all.each do |book|
      if input_name == book
        DB.exec("DELETE FROM books WHERE id = #{input_name.id};")
      end
    end
  end

  def self.find_by_name(input_book)
    book_arr = []
    Books.all.each do |book|
      if input_book == book.name
        results = DB.exec("SELECT * FROM books WHERE name = '#{input_book}';")
        results.each do |result|
          book_arr << result['name']
        end
      end
    end
    # name = book['name']
    # author = book['author']
    # id = book['id'].to_i
    book_arr
  end

  def save
    results = DB.exec("INSERT INTO books (name, author) VALUES ('#{@name}', '#{@author}') RETURNING id;")
    @id = results.first['id'].to_i
  end


  def ==(another_book)
    self.name == another_book.name && self.author == another_book.author
  end
end
