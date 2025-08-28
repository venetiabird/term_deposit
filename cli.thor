require_relative "boot"

require_relative "lib/calculator"
require_relative "lib/deposit_statement"

class Deposit < Thor
  package_name "Deposit"

  desc "calculate", "Earned on a term deposit over a term at a specific rate"

  option :help, type: :boolean, desc: "Show help"
  option :amount, type: :numeric, required: false, desc: "Initial deposit amount"
  option :rate, type: :numeric, required: false, default: 1.1, desc: "Interest rate (%)"
  option :term, type: :numeric, required: false, default: 36, desc: "Term in months"
  option :frequency, type: :string, required: false, default: "maturity", enum: ["monthly", "quarterly", "annually", "maturity"], desc: "Payment frequency (monthly, quarterly, annually, maturity)"
  
  def calculate
    if options[:help]
      self.class.help(shell, "calculate")
      return
    end

    begin
      enforce_required_options!

      saving_input = {
        amount: options[:amount],
        interest_rate: options[:rate],
        term: options[:term],
        payment_frequency: options[:frequency]
      } 
      puts DepositStatement.format_summary(Calculator.new(saving_input).final_balance)
    rescue StandardError => e
      puts "❌ An error occurred: #{e.message}"
      exit(1)
    end
  end

  def self.exit_on_failure?
    true
  end

  private 
  
  def enforce_required_options!
    unless options[:amount]
      puts "Error: --amount is required"
      exit(1)
    end
  end
end

