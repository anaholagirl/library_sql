class Author
  attr_accessor :name, :id

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id].to_i
  end

  def self.all
    entire_authors = []
    results = DB.exec("SELECT * FROM authors;")
    # binding.pry
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      entire_authors << Author.new({:name => name, :id => id})
    end
    entire_authors
  end

  def save
    results = DB.exec("INSERT INTO authors (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_author)
    self.name == another_author.name
  end
end
