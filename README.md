## Term Deposit Calculator

This is a command line interface (CLI) application to calculate the term interest on a term deposit. 

Its written in `Ruby`, using the `Thor` gem

It takes as inputs a starting deposit amount, interest rate, investment term and interest paid.

### TODO:
- add ruby version 


### Install dependencies and tests

Install the dependencies 

```bash

bundle install
```

Run all the tests

```bash 
bundle exec rspec ./spec
```

### CLI Commands

View the all commands available

```bash
thor list
```

View the `deposit` commands

```bash
thor desposit
```

Calculate the interest with specific inputs

```bash
thor deposit:final_payment --amount=10000 --rate=1.1 --term=36 --frequency=maturity
```

Calculate the interest for a specific starting amount using the program defaults

```bash
thor deposit:final_payment --amount=10000
```

where the defaults are

| Input            | Default Value | Notes               |
|------------------|---------------|---------------------|
| Interest Rate    | 1.1           | Annual percentage   |
| Investment Term  | 36            | Duration in months  |
| Interest paid    | maturity      | Payment timing      |


To get help on commands

```bash
thor deposit help final_payment
```


