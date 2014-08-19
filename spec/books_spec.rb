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
  end

  it 'gives the amount of the same book the library has' do
    test_book = Books.new({:name => "The Giving Tree", :author => 'Shel Silverstein'})
    test_book.save
    test_book1 = Books.new({:name => "The Giving Tree", :author => 'Shel Silverstein'})
    test_book1.save
    expect(test_book.copies).to eq 2
  end

  it 'should add a copy of a book to the same book' do
    test_book = Books.new({:name => "The Giving Tree", :author => 'Shel Silverstein'})
    test_book.save
    expect(Books.all).to eq [test_book]
    test_book.add_copies(1)
    expect(test_book.get_copies).to eq 2
  end

  it 'allows a patron to check out a book' do
    test_patron = Patron.new({:name => 'Joe Smith'})
    test_patron.save
    test_book = Books.new({:name => "The Giving Tree", :author => 'Shel Silverstein'})
    test_book.save
    test_book.checkout(test_patron.id)
    expect(Books.checked_out).to eq [test_book]
  end

end
