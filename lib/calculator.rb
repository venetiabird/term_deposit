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
    @payment_frequency = validated[:payment_frequency].to_sym 
  end
  
  def final_balance
    interest_rate = rate / 100
    payment_term = term.to_d / TWELVE_MONTHS

    return simple_interest(interest_rate, payment_term) unless payment_frequency != :maturity 
    compund_ineterest(interest_rate, payment_term)
  end

  def calulcate_projected_savings
    raise NotImplementedError, "calulcate_projected_savings not yet supported"
  end

  private 

  def simple_interest(interest_rate, payment_term)
    interest = (principal * interest_rate * (payment_term)).round(2)
    total_amount = principal + interest

    {
      final_amount: total_amount.to_f,
      interest: interest.to_f,
    }
  end

  def compund_ineterest(interest_rate, payment_term)
    compound_period =  CalulatorConstants::FREQUENCY_MAP[payment_frequency]
    period_rate = interest_rate / compound_period.to_d
    periods = compound_period.to_d * payment_term
    
    total_amount = principal * (1 + period_rate) ** ( periods )
    total_amount = total_amount.round(0)
    interest = (total_amount - principal).round()

    {
      final_amount: total_amount.to_f,
      interest: interest.to_f,
    }
  end
end