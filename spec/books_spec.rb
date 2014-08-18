require 'spec_helper'

describe 'Books' do
  it 'Initializes the Books class' do
    test_book = Books.new({:title => "The Giving Tree", :author => 'Shel Silverstein'})
    expect(test_book).to be_an_instance_of Books
  end

  it 'strats out as an empty library' do
    expect(Books.all).to eq []
  end
end
