require 'yaml'

# Calculate and create simple financial budgets
# by parsing a single YAML file as input
class Bouch
  def initialize(file)
    @assets = Array.new
    @pouch = YAML.safe_load(IO.read(file))
    @quarters = Hash.new
  end

  # Summarize and show aggregate asset totals
  def show_assets_total(assets)
    calc_assets(assets)
    puts '---------------'
    puts format('%-30s %.2f', 'Assets Total:', @assets.sum)
  end

  # Summarize and show all financial quarter budgets
  def show_quarters
    calc_quarters_raw(@pouch['Budget'])
    puts '---------------'
    4.times do |n|
      puts format('%-30s %.2f', 'Quarter' + (n + 1).to_s + ':', @quarters[n.to_s].sum)
    end
    puts '---------------'
  end

  # Summarize and show the aggregate annual budget totals
  def show_annual_total
    puts format('%-30s %.2f', 'Annual Total:', calc_quarters_raw_total.to_s)
  end

  # Summarize and show the aggregate annual budget as a percentage of income
  def show_budget_percentage(income)
    puts format('%-30s %.2f%s',
                'Budget Percent:',
                calc_budget_percentage(
                  calc_quarters_raw_total,
                  calc_salary(income['quantity'], income['frequency'])
                ),
                '%')
  end

  # Summarize and show annual income
  def show_annual_income(income)
    puts format('%-30s %.2f', 'Annual Salary:', calc_salary(income['quantity'], income['frequency']))
  end

  # Summarize and show all aggregate components of the quarterly, annual budgets, assets
  def show_budget
    show_quarters
    show_annual_total
    show_annual_income(@pouch['Salary'])
    show_budget_percentage(@pouch['Salary'])
    show_assets_total(@pouch['Assets'])
  end

  # Show the raw budget hash object parsed from the budget pouch YAML file
  def show_pouch
    puts @pouch
  end

  private

  # Calculate asset value aggregate amount
  def calc_assets(assets)
    assets.each do |_item, value|
      @assets.push(value)
    end
  end

  # Calculate the percentage of budget of a salary/income
  def calc_budget_percentage(total, salary)
    ((total.to_f / salary.to_f) * 100).round(2)
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
    budget.each do |_q, items|
      @quarters[@quarters.length.to_s] = Array.new
      items.each do |_item, value|
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
