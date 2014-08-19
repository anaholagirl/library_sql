require 'pry'

class Books
  attr_accessor :name, :author, :id, :availability

  def initialize(attributes)
    @name = attributes[:name]
    @author = attributes[:author]
    @id = attributes[:id].to_i
    if attributes[:availability] != nil
      @availability = attributes[:availability]
    else
      @availability = true
    end
  end

  def self.all
    entire_selection = []
    results = DB.exec("SELECT * FROM books;")
    results.each do |result|
      name = result['name']
      author = result['author']
      id = result['id'].to_i
      availability = result['availability'] == 't' ? true : false
      entire_selection << Books.new({:name => name, :author => author, :id => id, :availability => availability})
    end
    entire_selection
  end

  def self.available(input_book)
    @avail_books = []
    Books.all.each do |book|
      if input_book.availability == true
        @avail_books << book
      end
    end
    @avail_books
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

  def self.checked_out
    checked_books = []
    results = DB.exec("SELECT * FROM checkouts JOIN books ON (books.id = checkouts.books_id);")
    results.each do |book|
      name = book['name']
      author = book['author']
      checked_books << Books.new({:name => name, :author => author})
    end
    checked_books
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
    DB.exec("INSERT INTO copies (books_id, copies) VALUES (#{@id}, 1);")
  end


  def ==(another_book)
    self.name == another_book.name && self.author == another_book.author
  end

  def self.out_of_library(book_name)
    Books.all.each do |book|
      if book_name == book
        book.availability
      end
    end
  end

  def copies
    all_copies = []
    Books.all.each do |book|
      if book.name == self.name && book.author == self.author
        all_copies << book
      end
    end
    all_copies.length
  end

  def add_copies(num)
    copies = num + self.get_copies
    DB.exec("UPDATE copies SET copies = #{copies} WHERE books_id = #{@id};")
  end

  def get_copies
    results = DB.exec("SELECT copies FROM copies WHERE books_id = #{@id};")
    copies = results.first['copies'].to_i
  end

  def checkout(patron_id)
    DB.exec("INSERT INTO checkouts (patrons_id, books_id) VALUES (#{patron_id}, #{@id});")
    self.add_copies(-1)
  end
end
