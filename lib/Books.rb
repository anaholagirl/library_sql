class Books
  attr_accessor :title, :author, :id

  def initialize(attributes)
    @title = attributes[:title]
    @author = attributes[:author]
    @id = attributes[:id]
  end

  def self.all
    entire_selection = []
    results = DB.exec("SELECT * FROM books")
    results.each do |result|
      entire_selection << Books.new(result)
    end
    entire_selection
  end

  # def add
  #   DB.exec("INSERT INTO books (title, author) VALUES ('#{title}', '#{author}');")
end
