require 'yaml'

# Calculate and create simple financial budgets
# by parsing a single YAML file as input
class Bouch
  attr_accessor :assets, :debts, :pouch, :quarters

  def initialize(file)
    @assets = Array.new
    @debts = Array.new
    @pouch = YAML.safe_load(IO.read(file))
    @quarters = Hash.new
  end

  # Summarize and show aggregate asset totals
  def show_assets_total
    calc_assets(@pouch['Assets']) if @assets.empty?
    puts '----------------------'
    puts format('%-30s %.2f', 'Assets Total:', @assets.sum)
  end

  # Summarize and show aggregate liabilities totals
  def show_debts_total
    calc_debts(@pouch['Debts']) if @debts.empty?
    puts '----------------------'
    puts format('%-30s %.2f', 'Debt Total:', @debts.sum)
  end

  # Summarize and show debt ratio
  def show_debt_ratio
    calc_assets(@pouch['Assets']) if @assets.empty?
    calc_debts(@pouch['Debts']) if @debts.empty?
    puts format('%-30s %.4f', 'Debt Ratio:', calc_debt_ratio(@debts.sum, @assets.sum))
    puts format('%-30s %.2f%s', 'Debt Ratio Percent:',
                calc_debt_ratio_percent(calc_debt_ratio(@debts.sum, @assets.sum)),
                '%')
    puts '----------------------'
  end

  # Summarize and show all financial quarter budgets
  def show_quarters
    calc_quarters_raw(@pouch['Budget'])
    puts '----------------------'
    4.times do |n|
      puts format('%-30s %.2f', 'Quarter ' + (n + 1).to_s + ':', @quarters[n.to_s].sum)
    end
    puts '----------------------'
  end

  # Summarize and show the aggregate annual budget totals
  def show_annual_total
    puts format('%-30s %.2f', 'Budget Annual Total:', calc_quarters_raw_total.to_s)
  end

  # Summarize and show the aggregate annual budget as a percentage of income
  def show_budget_percentage(income)
    puts format('%-30s %.2f%s',
                'Budget Income Percent:',
                calc_budget_percentage(
                  calc_quarters_raw_total,
                  calc_salary(income['quantity'], income['frequency'])
                ),
                '%')
  end

  # Summarize and show annual income
  def show_annual_income(income)
    puts format('%-30s %.2f', 'Budget Annual Income:', calc_salary(income['quantity'], income['frequency']))
  end

  # Summarize and show all aggregate components of the quarterly, annual budgets, assets
  def show_budget
    show_quarters
    show_annual_total
    show_annual_income(@pouch['Salary'])
    show_budget_percentage(@pouch['Salary'])
    show_assets_total
    show_debts_total
    show_debt_ratio
  end

  private

  # Calculate asset value aggregate amount
  def calc_assets(assets)
    assets.each_value do |value|
      @assets.push(value)
    end
  end

  # Calculate the percentage of budget of a salary/income
  def calc_budget_percentage(total, salary)
    ((total.to_f / salary.to_f) * 100).round(2)
  end

  # Calculate debt/liability aggregate amount
  def calc_debts(debts)
    debts.each_value do |value|
      @debts.push(value)
    end
  end

  # Calculate a debt ratio: total debts divided by total assets
  def calc_debt_ratio(debts, assets)
    (debts.to_f / assets.to_f).round(4)
  end

  # Calculate a debt ratio percentage
  def calc_debt_ratio_percent(debt_ratio)
    (debt_ratio.to_f * 100).round(2)
  end

  # Calculate a quarterly repeating budget item amount
  def calc_repeating(item)
    (item.to_f * 3).round(2)
  end

  # Calculate an annual income based on a weekly frequency salary
  def calc_salary(amount, freq)
    (amount.to_f * (52 / freq)).round(2)
  end

  # Calculate each financial quarters budget items, including repeating ones
  def calc_quarters_raw(budget)
    budget.each_value do |items|
      @quarters[@quarters.length.to_s] = Array.new
      items.each_value do |value|
        case value
        when Hash
          if value.key?('repeat')
            @quarters[(@quarters.length - 1).to_s].push(calc_repeating(value['cost']))
          end
        else
          @quarters[(@quarters.length - 1).to_s].push(value)
        end
      end
    end
  end

  # Calculate all financial quarter budget into an aggregate annual budget
  def calc_quarters_raw_total
    @quarters['0'].sum + @quarters['1'].sum + @quarters['2'].sum + @quarters['3'].sum
  end
end
