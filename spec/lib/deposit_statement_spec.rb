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

    it 'formats valid calculated result' do
      summary = described_class.format_summary calculated_interest_result
      
      expect(summary).to include("Final balance: $10,335")
      expect(summary).to include("Interest earned: $335")
      expect(summary).to include("Paid at: maturity")
    end

    context 'when the input is invald' do 
      it 'formats an empty calculated result' do
        empty_result = {}
        summary = described_class.format_summary(empty_result)

        expect(summary).to include("Final balance: $")
        expect(summary).to include("Interest earned: $")
        expect(summary).to include("Paid at: ")
      end

      it 'formats a partial calculated' do
        partial_result = {
          balance: 10335.35,
          interest: "abc", 
          payout_frequency: :foo
        }
        summary = described_class.format_summary(partial_result)

        expect(summary).to include("Final balance: $10,335")
        expect(summary).to include("Interest earned: $0")
        expect(summary).to include("Paid at: foo")
      end
    end
  end
end
