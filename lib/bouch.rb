require 'yaml'
require 'bouch/calc'

# Calculate and create simple financial budgets
# by parsing a single YAML file as input
class Bouch
  attr_accessor :assets, :debts, :pouch, :quarters
  include BouchCalculate

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
    calc_quarters_raw(@pouch['Budget']) if @quarters.empty?
    puts '----------------------'
    4.times do |n|
      puts format('%-30s %.2f', 'Quarter ' + (n + 1).to_s + ':', @quarters[n.to_s].sum)
    end
    puts '----------------------'
  end

  # Summarize and show the aggregate annual budget totals
  def show_annual_total
    calc_quarters_raw(@pouch['Budget']) if @quarters.empty?
    puts format('%-30s %.2f', 'Budget Annual Total:', calc_quarters_raw_total.to_s)
  end

  # Summarize and show the aggregate annual budget as a percentage of income
  def show_budget_percentage
    calc_quarters_raw(@pouch['Budget']) if @quarters.empty?
    puts format('%-30s %.2f%s',
                'Budget Income Percent:',
                calc_budget_percentage(
                  calc_quarters_raw_total,
                  calc_salary(@pouch['Salary']['quantity'], @pouch['Salary']['frequency'])
                ),
                '%')
  end

  # Summarize and show annual income
  def show_annual_income
    puts format('%-30s %.2f',
                'Budget Annual Income:',
                calc_salary(@pouch['Salary']['quantity'], @pouch['Salary']['frequency']))
  end

  # Summarize and show all aggregate components of the quarterly, annual budgets, assets
  def show_budget
    show_quarters
    show_annual_total
    show_annual_income
    show_budget_percentage
    show_assets_total
    show_debts_total
    show_debt_ratio
  end
end
