require 'bouch'

describe Bouch do
  before :all do
    @yaml = File.realdirpath('pouch.example.yml')
    @bouch = Bouch.new(@yaml)
  end

  describe '#assets' do
    it 'returns an empty array of assets' do
      expect(@bouch.assets).to be_empty
    end
  end

  describe '#debts' do
    it 'returns an emptry array of debts' do
      expect(@bouch.debts).to be_empty
    end
  end

  describe '#pouch' do
    it 'loads the budget pouch YAML file' do
      expect(@bouch.pouch).to eq(YAML.safe_load(IO.read(@yaml)))
    end
  end

  describe '#quarters' do
    it 'returns an empty hash of fiscal quarters' do
      expect(@bouch.quarters).to be_empty
    end
  end

  describe '.show_assets_total' do
    it 'outputs financial budget assests sum' do
      expect { @bouch.show_assets_total }.to output.to_stdout
    end
  end

  describe '.show_debts_total' do
    it 'outputs financial budget debts sum' do
      expect { @bouch.show_debts_total }.to output.to_stdout
    end
  end

  describe '.show_debt_ratio' do
    it 'outputs financial budget debt ratio' do
      expect { @bouch.show_debt_ratio }.to output.to_stdout
    end
  end

  describe '.show_quarters' do
    it 'outputs financial budget quarters sums' do
      expect { @bouch.show_quarters }.to output.to_stdout
    end
  end

  describe '.show_annual_total' do
    it 'outputs financial budget quarters aggregate sum' do
      expect { @bouch.show_annual_total }.to output.to_stdout
    end
  end

  describe '.show_budget_percentage' do
    it 'outputs financial budget income percentage' do
      expect { @bouch.show_budget_percentage }.to output.to_stdout
    end
  end

  describe '.show_annual_income' do
    it 'outputs financial budget income sum' do
      expect { @bouch.show_annual_income }.to output.to_stdout
    end
  end

  describe '.show_budget' do
    it 'outputs all financial budget summed components' do
      expect { @bouch.show_budget }.to output.to_stdout
    end
  end
end
