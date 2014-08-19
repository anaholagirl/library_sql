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

  it 'allows a patron to check out a book' do
    test_patron = Patron.new({:name => 'Joe Smith'})
    test_patron.save
    test_book = Books.new({:name => "The Giving Tree", :author => 'Shel Silverstein'})
    test_book.save
    expect(test_patron.checkout(test_book)).to eq [test_book]
  end
end
