# frozen_string_literal: true

require 'yaml'
require 'bouch'
require 'bouch/calc'

describe BouchCalculate do
  before :all do
    @yaml = File.realdirpath('pouch.example.yml')
    @bouch = Bouch.new(@yaml)
  end

  describe '.calc_assets' do
    it 'pushes asset values to an Array and returns a Hash' do
      expect(@bouch.calc_assets(@bouch.pouch['Assets'])).to be_a_kind_of(Hash)
    end
    it 'creates array of assets greater than zero' do
      # Uncomment line below for Debug
      # puts @bouch.assets.inspect
      expect(@bouch.assets.length).to be > 0
    end
  end

  describe '.calc_budget_percentage' do
    context 'given a budget total and salary income total' do
      it 'returns a percentage of budget of a salary income' do
        expect(@bouch.calc_budget_percentage(12100.00, 28808.00)).to eq(42.00)
      end
    end
  end

  describe '.calc_debts' do
    it 'pushes debt values to an Array and returns a Hash' do
      expect(@bouch.calc_debts(@bouch.pouch['Debts'])).to be_a_kind_of(Hash)
    end
    it 'creates an array of debts greater than zero' do
      # Uncomment line below for Debug
      # puts @bouch.debts.inspect
      expect(@bouch.debts.length).to be > 0
    end
  end

  describe '.calc_debt_ratio' do
    context 'given a sum of debts and assets' do
      it 'returns a Float number' do
        expect(@bouch.calc_debt_ratio(420.00, 1000.00)).to be_a_kind_of(Float)
      end
      it 'returns a debt ratio' do
        expect(@bouch.calc_debt_ratio(420.00, 1000.00)).to eq(0.42)
      end
    end
  end

  describe '.calc_debt_ratio_percent' do
    context 'given a debt ratio' do
      it 'returns a Float number' do
        debt_ratio = @bouch.calc_debt_ratio(420.00, 1000.00)
        # Uncomment line below for Debug
        # puts debt_ratio
        expect(@bouch.calc_debt_ratio_percent(debt_ratio)).to be_a_kind_of(Float)
      end
      it 'returns a debt ratio percentage' do
        debt_ratio = @bouch.calc_debt_ratio(420.00, 1000.00)
        # Uncomment line below for Debug
        # puts debt_ratio
        expect(@bouch.calc_debt_ratio_percent(debt_ratio)).to eq(42.00)
      end
    end
  end

  describe '.calc_repeating' do
    context 'given a numerical cost amount' do
      it 'returns a Float number' do
        expect(@bouch.calc_repeating(1000)).to be_a_kind_of(Float)
      end
      it 'returns a number three times that amount' do
        expect(@bouch.calc_repeating(1000)).to eq(3000.00)
      end
    end
  end

  describe '.calc_salary' do
    context 'given a salary amount and weekly frequency' do
      it 'returns a Float number' do
        expect(@bouch.calc_salary(1108.00, 2)).to be_a_kind_of(Float)
      end
      it 'returns an annual income total' do
        expect(@bouch.calc_salary(1108.00, 2)).to eq(28808.00)
      end
    end
  end

  describe '.calc_quarters_raw' do
    context 'given a quarterly budget' do
      it 'pushes quarterly budget items to a collection of Arrays and returns a Hash' do
        expect(@bouch.calc_quarters_raw(@bouch.pouch['Budget'])).to be_a_kind_of(Hash)
      end
      it 'creates an array of financial quarter one budget items greater than zero' do
        # Uncomment line below for Debug
        # puts @bouch.quarters['0'].inspect
        expect(@bouch.quarters['0'].length).to be > 0
      end
      it 'creates an array of financial quarter two budget items greater than zero' do
        # Uncomment line below for Debug
        # puts @bouch.quarters['1'].inspect
        expect(@bouch.quarters['1'].length).to be > 0
      end
      it 'creates an array of financial quarter three budget items greater than zero' do
        # Uncomment line below for Debug
        # puts @bouch.quarters['2'].inspect
        expect(@bouch.quarters['2'].length).to be > 0
      end
      it 'creates an array of financial quarter four budget items greater than zero' do
        # Uncomment line below for Debug
        # puts @bouch.quarters['3'].inspect
        expect(@bouch.quarters['3'].length).to be > 0
      end
    end
  end

  describe '.calc_quarters_raw_total' do
    context 'given arrays of quarterly budget items' do
      it 'returns a Float number' do
        expect(@bouch.calc_quarters_raw_total).to be_a_kind_of(Float)
      end

      it 'returns a financial quarter aggregate sum' do
        expect(@bouch.calc_quarters_raw_total).to eq(12100.00)
      end
    end
  end
end
