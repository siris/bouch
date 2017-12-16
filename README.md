# bouch
The budget pouch. A simple tool to calculate and project your annual personal budget based on fiscal quarters expenditures, income, and total assets.

Use it to help establish an annual financial plan and set monetary goals.

## Usage

Bouch takes a simple YAML file as its primary input. This will be referred to as a budget pouch file.

There is an example budget pouch file called **pouch.example.yml**.

Use this budget pouch file and execute the following command on your favorite terminal emulator command-line interface:

```
./bouch pouch.example.yml
```

You should see the example budget summary output:

```
---------------
Quarter1:                      3025.00
Quarter2:                      3025.00
Quarter3:                      3025.00
Quarter4:                      3025.00
---------------
Annual Total:                  12100.00
Annual Salary:                 28808.00
Budget Percent:                42%
---------------
Assets Total:                  1000.00
```

### Pouch Schema

To use bouch to calculate your own budget you must create a budget pouch file.

Budget pouch files are written in Ruby friendly YAML and currently use the following schema:

* Deeply nested mappings, also know as hashes
* Primary hash keys:
  * **Budget**
  * **Salary**
* Budget nested keys and values:
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
* Salary nested keys and values:
  * **quantity**
      * Value: Float or Integer
      * Equals amount of after-tax money per salary pay period
  * **frequency**
      * Value: Integer
      * Equals number of weeks for each salary pay period
* Assets nested keys and values:
  * foo
      * Value: Integer or Float
      * Equals an asset's total valued amount

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
...

```
