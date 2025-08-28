class DepositStatement
  def self.format_summary(result)
    "Final balance: $#{format_currency(result[:balance])}, Interest earned: $#{format_currency(result[:interest])}, Paid at: #{result[:payout_frequency]}"
  end

  def self.format_currency(amount)
    amount.round.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
  end
end