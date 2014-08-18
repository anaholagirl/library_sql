require 'pry'

class Books
  attr_accessor :name, :author, :id, :availability

  def initialize(attributes)
    @name = attributes[:name]
    @author = attributes[:author]
    @id = attributes[:id].to_i
    @availability = true
  end

  def self.all
    entire_selection = []
    results = DB.exec("SELECT * FROM books;")
    # binding.pry
    results.each do |result|
      name = result['name']
      author = result['author']
      id = result['id'].to_i
      availability = result['true']
      entire_selection << Books.new({:name => name, :author => author, :id => id, :availability => availability})
    end
    entire_selection
  end

  def self.available(input_book)
    avail_books = []
    Books.all.each do |book|
      if input_book.availability == true
        avail_books << book
      end
    end
    avail_books
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
    book_arr
  end

  def self.find_by_author(input_author)
    book_arr = []
    Books.all.each do |book|
      if input_author == book.author
        results = DB.exec("SELECT * FROM books WHERE author = '#{input_author}';")
        results.each do |result|
          book_arr << result['name']
        end
      end
    end
    book_arr
  end

  def save
    results = DB.exec("INSERT INTO books (name, author, availability) VALUES ('#{@name}', '#{@author}', '#{@availability}') RETURNING id;")
    @id = results.first['id'].to_i
  end


  def ==(another_book)
    self.name == another_book.name && self.author == another_book.author
  end


end
