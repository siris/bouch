
# Financial budget calculation and operations for Bouch
module BouchCalculate
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
