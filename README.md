# Bouch
[![GitLab Migration](https://img.shields.io/badge/GitLab%20Migration-Completed-brightgreen.svg)](https://gitlab.com/ssofos/bouch)

`Bouch` is the budget pouch. A simple tool to calculate and project your annual personal budget based on fiscal quarter expenditures, income, assets, and debts.

Use it to help establish an annual financial plan, set monetary goals, and gain perspective on your financial health.

## Install

To install bouch simply:

* Clone this git repository and install bouch as a local RubyGem

To clone this git repository execute this command in a terminal emulator's command-line interface:

```
git clone https://github.com/siris/bouch.git
```

To install bouch as a local RubyGem simply run these commands in a terminal emulator's CLI:

```
cd bouch
gem build bouch.gemspec
gem install bouch-X.X.X.gem
```

## Usage

Bouch takes a simple YAML file as its primary data input. This will be referred to as a budget pouch file.

There is an example budget pouch file called **pouch.example.yml**.

Use this budget pouch file and execute the following command on your favorite terminal emulator's CLI:

```
bouch pouch.example.yml
```

You should see the example budget summary output:

```
----------------------
Quarter 1:                     3025.00
Quarter 2:                     3025.00
Quarter 3:                     3025.00
Quarter 4:                     3025.00
----------------------
Budget Annual Total:           12100.00
Budget Annual Income:          28808.00
Budget Income Percent:         42.00%
----------------------
Assets Total:                  1000.00
----------------------
Debt Total:                    420.00
Debt Ratio:                    0.4200
Debt Ratio Percent:            42.00%
----------------------
```

### Pouch Schema

To use bouch to calculate your own budget you must create a customized budget pouch file.

Budget pouch files are written in Ruby friendly YAML and currently use the following schema:

* Deeply nested mappings, also know as hashes
* Think of hashes as simple groupings of keys and values
* Primary hash keys:
  * **Budget**
  * **Salary**
  * **Assets**
  * **Debts**
* **Budget** nested keys and values:
    * **Q1**
        * foo
            * Value: Integer or Float
            * Equals a budget item's quarterly cost
        * bar
            * **cost**
                * Value: Integer or Float
                * Equals the monthly cost of any repeated payment
            * **repeat**
                * Value: true
                * Enables quarterly auto-calculation of the repeat payment
  * **Q2**
      * Same nested schema as Q1
  * **Q3**
      * Same nested schema as Q1
  * **Q4**
      * Same nested schema as Q1
* **Salary** nested keys and values:
  * **quantity**
      * Value: Float or Integer
      * Equals amount of after-tax money per salary pay period
  * **frequency**
      * Value: Integer
      * Equals number of weeks for each salary pay period
* **Assets** nested keys and values:
  * foo
      * Value: Integer or Float
      * Equals an asset's total valued amount
* **Debts** nested keys and values:
  * bar
      * Value: Integer or Float
      * Equals a debt's total valued amount
* All non-primary nested keys are case insensitive

Here is an simple example of of budget pouch file:

```
---
Budget:
  Q1:
    Rent:
      cost: 1000
      repeat: true
    foo: 20
    bar: 5
  Q2:
    Rent:
      cost: 1000
      repeat: true
    fizz: 20
    buzz: 5
  Q3:
    Rent:
      cost: 1000
      repeat: true
    bubble: 20
    sort: 5
  Q4:
    Rent:
      cost: 1000
      repeat: true
    baz: 20
    qax: 5
Salary:
  quantity: 1108.00
  frequency: 2
Assets:
  foo: 500
  bar: 500
Debts:
  baz: 120
  qax: 300
...
```
