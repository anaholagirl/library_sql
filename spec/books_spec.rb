require 'spec_helper'

describe 'Books' do
  it 'Initializes the Books class' do
    test_book = Books.new({:name => "The Giving Tree", :author => 'Shel Silverstein'})
    expect(test_book).to be_an_instance_of Books
  end

  it 'starts out as an empty library' do
    expect(Books.all).to eq []
  end

  it 'adds a book into the books table' do
    test_book = Books.new({:name => "The Giving Tree", :author => 'Shel Silverstein'})
    test_book.save
    expect(Books.all).to eq [test_book]
  end

  it 'deletes a book from the books table' do
    test_book = Books.new({:name => "The Giving Tree", :author => 'Shel Silverstein'})
    test_book.save
    test_book1 = Books.new({:name => "The Notebook", :author => 'Nicholas Sparks'})
    test_book1.save
    Books.delete(test_book)
    expect(Books.all).to eq [test_book1]
  end

  it 'finds a book from the books table with a specific name' do
    test_book = Books.new({:name => "The Giving Tree", :author => 'Shel Silverstein'})
    test_book.save
    test_book1 = Books.new({:name => "The Notebook", :author => 'Nicholas Sparks'})
    test_book1.save
    # Books.find_by_name(test_book.name)
    expect(Books.find_by_name(test_book.name)).to eq [test_book.name]
  end

  it 'finds a book from the books table with a author' do
    test_book = Books.new({:name => "The Giving Tree", :author => 'Shel Silverstein'})
    test_book.save
    test_book1 = Books.new({:name => "The Notebook", :author => 'Nicholas Sparks'})
    test_book1.save
    # Books.find_by_name(test_book.name)
    expect(Books.find_by_author(test_book.author)).to eq [test_book.name]
  end

  it 'tells you if a book is available or not' do
    test_book = Books.new({:name => "The Giving Tree", :author => 'Shel Silverstein'})
    test_book.save
    expect(test_book.availability).to eq true
  end

  it 'changes the availability from true to false' do
    test_patron = Patron.new({:name => 'Joe Smith'})
    test_patron.save
    test_book = Books.new({:name => "The Giving Tree", :author => 'Shel Silverstein'})
    test_book.save
    test_patron.checkout(test_book)
    expect(Books.all.first.availability).to eq false
  end

  it 'gives the amount of the same book the library has' do
    test_book = Books.new({:name => "The Giving Tree", :author => 'Shel Silverstein'})
    test_book.save
    test_book1 = Books.new({:name => "The Giving Tree", :author => 'Shel Silverstein'})
    test_book1.save
    expect(test_book.copies).to eq 2
  end

end
