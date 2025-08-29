## Term Deposit Calculator

This is a command line interface (CLI) application to calculate the term interest on a term deposit. 

Its written in `Ruby`, using the `Thor` gem

It takes as inputs a starting deposit amount, interest rate, investment term and interest paid.

Interest calculation used
- [Compound interest](https://www.calculatorsoup.com/calculators/financial/compound-interest-calculator.php)
- [Simple interest](https://www.calculatorsoup.com/calculators/financial/simple-interest-plus-principal-calculator.php)

### Requirements

- Ruby 3.x (or the version specified in `.ruby-version`)
- Bundler

### Dependencies and tests

Install the dependencies 

```bash

bundle install
```

Run the tests

```bash 
bundle exec rspec ./spec
```

Using guard to run tests while developing

```bash
bundle exec guard
```

### Quick start

Calculate the interest with specific inputs

```bash
bin/deposit calculate --amount=10000 --rate=1.1 --term=36 --frequency=maturity
```

Calculate the interest for a specific starting amount using the program defaults

```bash
bin/deposit calculate --amount=10000
```

where the defaults are

| Input            | Default Value | Notes               |
|------------------|---------------|---------------------|
| Interest Rate    | 1.1           | Annual percentage   |
| Investment Term  | 36            | Duration in months  |
| Interest paid    | maturity      | Payment timing      |


### CLI Commands

View the available commands

```bash
bin/deposit help
```

Show the list of `deposit` related commands

```bash
bin/deposit help calculate
```

View help on `calculate` commands

```bash
bin/deposit help calculate

# or

bin/deposit calculate --help
```

### License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT).

### Things that are bugging me

- calculator spec with fractional initial value for compound calculation I think has a rounding issue. Would have liked to add more specs in this area. Specifically large initial amounts and acceptable errors. Other boundary/edge case specs I suspect are missing too. On refelction the rounding rules could be encapsulated in their own class which would allow for easier and more tests. And if the rounding rules needed changing, then it would be in a single spot.
- cli.rb is out in the root folder, preference would be to move into lib
- does the projected savings method need to be implemented?

