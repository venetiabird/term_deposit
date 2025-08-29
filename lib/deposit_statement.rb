class DepositStatement
  def self.format_summary(result)
    balance = format_currency(result[:balance] || 0)
    interest = format_currency(result[:interest] || 0)
    frequency = result[:payout_frequency] || ""

    "Final balance: $#{balance}, Interest earned: $#{interest}, Paid at: #{frequency}"
  end

  def self.format_currency(amount)
    amount = 0 if amount.nil?
    amount = 0 if amount.to_d == 0.0
    amount.round.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
  end
end