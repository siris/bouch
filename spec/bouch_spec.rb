require 'bouch'

describe Bouch do
  before :all do
    @yaml = File.realdirpath('pouch.example.yml')
    @bouch = Bouch.new(@yaml)
  end

  describe '.assets' do
    it 'returns an empty array of assets' do
      expect(@bouch.assets).to be_empty
    end
  end

  describe '.debts' do
    it 'returns an emptry array of debts' do
      expect(@bouch.debts).to be_empty
    end
  end

  describe '.pouch' do
    it 'loads the budget pouch YAML file' do
      expect(@bouch.pouch).to eq(YAML.safe_load(IO.read(@yaml)))
    end
  end

  describe '.quarters' do
    it 'returns an empty hash of fiscal quarters' do
      expect(@bouch.quarters).to be_empty
    end
  end
end
