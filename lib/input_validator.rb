require "bigdecimal"
require "bigdecimal/util"

require 'constants'
require 'pry'

class InputValidator
  MINIMUM_DEPOSIT = 1000
  MINIMUM_TERM = 3

  def self.validate_and_convert(raw)
    amount = raw[:amount].to_d
    interest_rate = raw[:interest_rate].to_d
    term = raw[:term].to_i if raw[:term]
    payment_frequency = raw[:payment_frequency].to_sym
    
    errors = []
    errors << "Starting deposit must be at least $1000" if amount < MINIMUM_DEPOSIT
    errors << "Interest rate must be a positive number" if interest_rate < 0
    errors << "Term must be at least 3 months" if raw[:term].to_i < MINIMUM_TERM
    errors << "Payment frequency must be one of: #{CalulatorConstants::FREQUENCY_MAP.keys.join(', ')}" unless CalulatorConstants::FREQUENCY_MAP.keys.include?(payment_frequency)

    raise ArgumentError, errors.join("\n") if errors.any?
    {
      amount: amount,
      interest_rate: interest_rate,
      term: term,
      payment_frequency: payment_frequency
    }
  end
end
