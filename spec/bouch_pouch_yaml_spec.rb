require 'yaml'

@yaml = File.realdirpath('pouch.example.yml')
@pouch = YAML.safe_load(IO.read(@yaml))

describe 'Pouch YAML Schema' do
  before :all do
    @yaml = File.realdirpath('pouch.example.yml')
    @pouch = YAML.safe_load(IO.read(@yaml))
  end

  it 'has four major Hash keys' do
    expect(@pouch.keys.length).to eq(4)
  end

  it 'has a hash key named Budget' do
    expect(@pouch.key?('Budget')).to be_truthy
  end

  it 'has a hash key named Salary' do
    expect(@pouch.key?('Salary')).to be_truthy
  end

  it 'has a hash key named Assets' do
    expect(@pouch.key?('Assets')).to be_truthy
  end

  it 'has a hash key named Debts' do
    expect(@pouch.key?('Debts')).to be_truthy
  end

  it 'has Budget values that are Hashes' do
    expect(@pouch['Budget']).to be_a_kind_of(Hash)
  end

  it 'has Salary values that are Hashes' do
    expect(@pouch['Salary']).to be_a_kind_of(Hash)
  end

  it 'has Asset values that are Hashes' do
    expect(@pouch['Assets']).to be_a_kind_of(Hash)
  end

  it 'has Debt values that are Hashes' do
    expect(@pouch['Debts']).to be_a_kind_of(Hash)
  end
end
