require 'calculator'
RSpec.describe Calculator do
  let(:payment_frequency) { :maturity }
  let(:term) { 36 }
  let(:amount) { 10000 }
  let(:interest) { 1.1 }
  let(:inputs) { { amount: amount, interest_rate: interest, term: term, payment_frequency: payment_frequency } }

  subject { described_class.new(inputs) }
  describe '#final_balance' do

  {
    maturity: { balance: 10330, interest: 330 },
    monthly:  { balance: 10335.35, interest: 335.35 },
    quarterly:{ balance: 10335.04, interest: 335.04 },
    annually: { balance: 10333.64, interest: 333.64 }
  }.each do |freq, expected|
    context "with #{freq} frequency" do
      let(:payment_frequency) { freq }

      it "calculates final amount and interest correctly" do
        expect(subject.final_balance[:balance]).to eq(expected[:balance])
        expect(subject.final_balance[:interest]).to eq(expected[:interest])
        expect(subject.final_balance[:payout_frequency]).to eq(freq.to_s)
      end
    end
  end

    context 'edge cases at maturity' do

      context 'with the minimum term' do
        let(:term) { 3 }

        it 'returns the calculated interest and final balance for the minimum term' do
          expect(subject.final_balance[:balance]).to eq(10027.5)
          expect(subject.final_balance[:interest]).to eq(27.5)
          expect(subject.final_balance[:payout_frequency]).to eq(payment_frequency.to_s)
        end
      end

      context 'with the minimum initial amount' do
        let(:amount) { 1000 }

        it 'returns the calculated interest and final balance for the minimum initial amount' do
          expect(subject.final_balance[:balance]).to eq(1033)
          expect(subject.final_balance[:interest]).to eq(33)
          expect(subject.final_balance[:payout_frequency]).to eq(payment_frequency.to_s)
        end
      end

      context 'with zero interest rate' do
        let(:interest) { 0.0 }

        it 'returns the calculated interest and final balance for zero interset' do
          expect(subject.final_balance[:balance]).to eq(10000)
          expect(subject.final_balance[:interest]).to eq(0)
          expect(subject.final_balance[:payout_frequency]).to eq(payment_frequency.to_s)
        end
      end

      context 'with large interest rate' do
        let(:interest) { 15.0 }

        it 'returns the calculated interest and final balance for zero interset' do
          expect(subject.final_balance[:balance]).to eq(14500.00)
          expect(subject.final_balance[:interest]).to eq(4500.00)
          expect(subject.final_balance[:payout_frequency]).to eq(payment_frequency.to_s)
        end
      end

      [
        { 
          input: 1000.35, expected: "1033.00",
          input: 1000.99, expected: "1034.03"
        }
      ].each do |data|
        context 'with fractional initial amount' do
          let(:amount) { data[:input]}

          it 'returns the calculated interest and final balance' do
            expect(subject.final_balance[:balance].ceil(2)).to eq(BigDecimal(data[:expected]))
            expect(subject.final_balance[:payout_frequency]).to eq(payment_frequency.to_s)
          end
        end
      end

            [
        { 
          input: 1400000.25, expected: "1446200.00"
        }
      ].each do |data|
        context 'with very large initial amounts' do
          let(:amount) { data[:input]}

          it 'returns the calculated interest and final balance' do
            result = subject.final_balance[:balance].to_f

            expect(result).to be_within(0.3).of(BigDecimal(data[:expected]))
            expect(subject.final_balance[:payout_frequency]).to eq(payment_frequency.to_s)
          end
        end
      end
    end

    context 'edge cases at quarterly' do
      let(:payment_frequency) { :quarterly }

      context 'with the minimum term' do
        let(:term) { 3 }

        it 'returns the calculated interest and final balance for the minimum term' do
          expect(subject.final_balance[:balance]).to eq(10027.5)
          expect(subject.final_balance[:interest]).to eq(27.5)
          expect(subject.final_balance[:payout_frequency]).to eq(payment_frequency.to_s)
        end
      end

      context 'with the minimum initial amount' do
        let(:amount) { 1000 }

        it 'returns the calculated interest and final balance for the minimum initial amount' do
          expect(subject.final_balance[:balance]).to eq(1033.50)
          expect(subject.final_balance[:interest]).to eq(33.50)
          expect(subject.final_balance[:payout_frequency]).to eq(payment_frequency.to_s)
        end
      end

      context 'with zero interest rate' do
        let(:interest) { 0.0 }

        it 'returns the calculated interest and final balance for zero interset' do
          expect(subject.final_balance[:balance]).to eq(10000)
          expect(subject.final_balance[:interest]).to eq(0)
          expect(subject.final_balance[:payout_frequency]).to eq(payment_frequency.to_s)
        end
      end

      context 'with large interest rate' do
        let(:interest) { 15.0 }

        it 'returns the calculated interest and final balance for zero interset' do
          expect(subject.final_balance[:balance]).to eq(15554.54)
          expect(subject.final_balance[:interest]).to eq(5554.54)
          expect(subject.final_balance[:payout_frequency]).to eq(payment_frequency.to_s)
        end
      end

      [
        { 
          input: 1000.35, expected: "1033.50",
          input: 1000.99, expected: "1034.54",
        }
      ].each do |data|
        context 'with fractional initial amount' do
          let(:amount) { data[:input]}

          it 'returns the calculated interest and final balance' do
            result = subject.final_balance[:balance].to_f
            # expect(subject.final_balance[:balance].ceil(2)).to eq(BigDecimal(data[:expected]))
            expect(result).to be_within(0.01).of(BigDecimal(data[:expected]))
            expect(subject.final_balance[:payout_frequency]).to eq(payment_frequency.to_s)
          end
        end
      end

      [
        { 
          input: 1400000.25, expected: "1446905.22"
        }
      ].each do |data|
        context 'with very large initial amounts' do
          let(:amount) { data[:input]}

          it 'returns the calculated interest and final balance' do
            result = subject.final_balance[:balance].to_f

            expect(result).to be_within(0.3).of(BigDecimal(data[:expected]))
            expect(subject.final_balance[:payout_frequency]).to eq(payment_frequency.to_s)
          end
        end
      end
    end
  end
end
