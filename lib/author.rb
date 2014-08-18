class Author
  attr_accessor :name, :id

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id].to_i
  end
end
