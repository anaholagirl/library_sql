require 'spec_helper'

describe 'Author' do
  it 'Initializes the Author class' do
    test_author = Author.new({:name => 'Shel Silverstein'})
    expect(test_author).to be_an_instance_of Author
  end

  it 'starts as an empty array' do
    expect(Author.all).to eq []
  end

  it 'adds an author into the authors table' do
    test_author = Author.new({:name => 'Shel Silverstein'})
    test_author.save
    expect(Author.all).to eq [test_author]
  end

  it 'adds a book to an author' do
    test_book = Books.new({:name => "The Giving Tree"})
    test_book.save
    test_author = Author.new({:name => 'Shel Silverstein'})
    test_author.save
    test_author.add_book(test_book)
    results = DB.exec('SELECT * FROM books_authors;')
    expect(results.first['books_id'].to_i).to eq test_book.id
    expect(results.first['authors_id'].to_i).to eq test_author.id
  end
end
