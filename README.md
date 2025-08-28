## Term Deposit Calculator

This is a command line interface (CLI) application to calculate the term interest on a term deposit. 

Its written in `Ruby`, using the `Thor` gem

It takes as inputs a starting deposit amount, interest rate, investment term and interest paid.

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

### Quick start

Calculate the interest with specific inputs

```bash
thor deposit:calculate --amount=10000 --rate=1.1 --term=36 --frequency=maturity
```

Calculate the interest for a specific starting amount using the program defaults

```bash
thor deposit:calculate --amount=10000
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
thor list
```

Show the list of `deposit` related commands

```bash
thor deposit
```

View help on commands

```bash
thor deposit help calculate

# or

thor deposit:calculate --help
```

### License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT).


