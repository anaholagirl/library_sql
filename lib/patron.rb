require 'pry'

class Patron
  attr_accessor :name, :id

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id].to_i
  end

  def self.all
    entire_patrons = []
    results = DB.exec("SELECT * FROM patrons;")
    # binding.pry
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      entire_patrons << Patron.new({:name => name, :id => id})
    end
    entire_patrons
  end

  def save
    results = DB.exec("INSERT INTO patrons (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_patron)
    self.name == another_patron.name
  end

end

  # def checkout(input_book)
  #   @my_books = []
  #   if input_book.availability
  # end

  # def history
  #   books = []
  #   results = DB.exec("SELECT * FROM checkouts WHERE patrons_id = #{self.id};")
  #   # binding.pry
  #   results.each do |result|
  #     # binding.pry
  #     book_id = DB.exec("SELECT * FROM copies WHERE id = #{result['copies_id'].to_i}").first
  #     book_query = DB.exec("SELECT * FROM books WHERE id = #{book_id['books_id'].to_i}")
  #     book_name = book_query.first['name']
  #     book_author = book_query.first['author']
  #     books << Book.new({name: book_name, author: book_author})
  #   end
  #   books
  # end
