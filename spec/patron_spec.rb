require 'spec_helper'

describe 'Patron' do
  it 'Initializes the Patron class' do
    test_patron = Patron.new({:name => "Joe Smith"})
    expect(test_patron).to be_an_instance_of Patron
  end

  it 'starts as an empty array' do
    expect(Patron.all).to eq []
  end

  it 'adds a patron into the patrons table' do
    test_patron = Patron.new({:name => 'Joe Smith'})
    test_patron.save
    expect(Patron.all).to eq [test_patron]
  end



  # it 'gives a history of all the books a patron has checked out' do
  #   test_patron = Patron.new({:name => 'Joe Smith'})
  #   test_patron.save
  #   test_book = Books.new({:name => "The Giving Tree", :author => 'Shel Silverstein'})
  #   test_book.save
  #   test_book1 = Books.new({:name => "The Giving Tree", :author => 'Shel Silverstein'})
  #   test_book1.save
  #   test_patron.checkout(test_book)
  #   test_patron.checkout(test_book1)
  #   expect(test_patron.history).to eq [test_book, test_book1]
  # end
end
