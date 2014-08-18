require 'pry'

class Books
  attr_accessor :title, :author, :id

  def initialize(attributes)
    @title = attributes[:title]
    @author = attributes[:author]
    @id = attributes[:id].to_i
  end

  def self.all
    entire_selection = []
    results = DB.exec("SELECT * FROM books;")
    # binding.pry
    results.each do |result|
      title = result['title']
      author = result['author']
      id = result['id'].to_i
      entire_selection << Books.new({:title => title, :author => author, :id => id})
    end
    entire_selection
  end

  def save
    results = DB.exec("INSERT INTO books (title, author) VALUES ('#{@title}', '#{@author}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def self.delete(input_title)
    Books.all.each do |book|
      if input_title == book
        DB.exec("DELETE FROM books WHERE id = #{input_title.id};")
      end
    end
  end

  def ==(another_book)
    self.title == another_book.title && self.author == another_book.author
  end
end
