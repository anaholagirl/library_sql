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

end
