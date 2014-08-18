require 'spec_helper'

describe 'Author' do
  it 'Initializes the Author class' do
    test_author = Author.new({:name => 'Shel Silverstein'})
    expect(test_author).to be_an_instance_of Author
  end
end
