require 'yaml'

class Bouch
  def initialize(file)
    @pouch = YAML.safe_load(IO.read(file))
    @quarters = Hash.new
  end

  def show_quarters
    calc_quarters_raw(@pouch['Budget'])
    puts '---------------'
    4.times do |n|
      puts format('%s %20.2f', 'Quarter' + (n + 1).to_s + ':', @quarters[n.to_s].sum)
    end
    puts '---------------'
  end

  def show_annual_total
    puts format('%s %17.2f', 'Annual Total:', calc_quarters_raw_total.to_s)
  end

  def show_budget_percentage(income)
    puts format('%s %12.2f%s',
                'Budget Percent:',
                calc_budget_percentage(
                  calc_quarters_raw_total,
                  calc_salary(income['quantity'], income['frequency'])
                ),
                '%')
  end

  def show_income(income)
    puts format('%s %16.2f', 'Annual Salary:', calc_salary(income['quantity'], income['frequency']))
  end

  def show_budget
    show_quarters
    show_annual_total
    show_income(@pouch['Salary'])
    show_budget_percentage(@pouch['Salary'])
  end

  def show_pouch
    puts @pouch
  end

  private

  def calc_budget_percentage(total, salary)
    ((total.to_f / salary.to_f) * 100).round(2)
  end

  def calc_repeating(item)
    (item.to_f * 3).round(2)
  end

  def calc_salary(amount, freq)
    (amount.to_f * (52 / freq)).round(2)
  end

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

  def calc_quarters_raw_total
    @quarters['0'].sum + @quarters['1'].sum + @quarters['2'].sum + @quarters['3'].sum
  end
end
