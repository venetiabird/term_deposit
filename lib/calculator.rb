require 'input_validator'
require 'constants'

class Calculator
  TWELVE_MONTHS = 12

  attr_reader :principal, :rate, :term, :payment_frequency

  def initialize(saving_input)
    validated = InputValidator.validate_and_convert(saving_input)
    @principal = validated[:amount]
    @rate = validated[:interest_rate]
    @term = validated[:term]
    @payment_frequency = validated[:payment_frequency] 
  end
  
  def final_balance

    interest_rate = rate / 100
    term_years = term.to_d / TWELVE_MONTHS

    return simple_interest(interest_rate, term_years) if payment_frequency == :maturity
    compund_interest(interest_rate, term_years)
  end

  private 

  def simple_interest(interest_rate, term_years)
    interest = (principal * interest_rate * (term_years))
    total_amount = principal + interest

    {
      balance: total_amount.to_d, 
      interest: interest.round(2).to_d,
      payout_frequency: payment_frequency.to_s
    }
  end

  def compund_interest(interest_rate, term_years)
    compound_period =  CalulatorConstants::FREQUENCY_MAP[payment_frequency]
    period_rate = interest_rate / compound_period
    periods = compound_period * term_years
    
    total_amount = principal * (1 + period_rate) ** ( periods )

    {
      balance: total_amount.round(2).to_d,
      interest: (total_amount - principal).round(2).to_d,
      payout_frequency: payment_frequency.to_s
    }
  end
end
