require 'deposit_statement'

RSpec.describe DepositStatement do
  
  describe '.format_summary' do
    let(:calculated_interest_result) do  
      {
        balance: 10335.35,
        interest: 335.35, 
        payout_frequency: :maturity
      }
    end

    it 'formats the calculated result' do
      summary = described_class.format_summary calculated_interest_result
      
      expect(summary).to include("Final balance: $10,335")
      expect(summary).to include("Interest earned: $335")
      expect(summary).to include("Paid at: maturity")
    end
  end
end