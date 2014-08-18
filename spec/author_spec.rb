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
end
