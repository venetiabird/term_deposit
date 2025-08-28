
require 'input_validator'

RSpec.describe InputValidator do
  subject { described_class }

  describe '.validate_and_convert' do

    let(:valid_input) { { amount: 10000.00, interest_rate: 1.1, term: 12, payment_frequency: :maturity } }
    
    context 'when all input is valid' do
      it 'does not raise an argument exception' do
        expect { subject.validate_and_convert(valid_input) }.not_to raise_error
      end
    end

    context 'with varying decimals on amount' do
      let(:invalid_input) { valid_input.merge(amount: 1000.154) }

      it 'returns the correct amount' do
        validated = subject.validate_and_convert(invalid_input)
        expect(validated[:amount]).to eq 1000.15
      end
    end

    [500, -100].each do |amount|
      context "with invalid amount #{amount}" do
        let(:invalid_input) { valid_input.merge(amount: 500) }
        it 'raises an error about minimum amount' do
          expect { subject.validate_and_convert(invalid_input) }.to raise_error(ArgumentError, "Starting deposit must be at least $1000")
        end
      end
    end

    context 'with invalid interest rate' do
      let(:invalid_input) { valid_input.merge(interest_rate: -1)}

      it 'raises an error about positive interest rate' do
        expect { subject.validate_and_convert(invalid_input) }.to raise_error(ArgumentError, "Interest rate must be a positive number")
      end
    end

    [2, -1].each do |term|
      context "with invalid term #{term}" do
        let(:invalid_input) { valid_input.merge(term: term) }

        it 'raises an error about the minimum term' do
          expect { subject.validate_and_convert(invalid_input) }.to raise_error(ArgumentError, "Term must be at least 3 months")
        end
      end
    end

    [:daily, "foo", 1].each do |frequency|
      context "with invalid repayment frequency #{frequency}" do
        let(:invalid_input) { valid_input.merge(payment_frequency: :daily)} 

        it 'raises an exception about the repayment frequency' do
          expect { subject.validate_and_convert(invalid_input)}.to raise_error(ArgumentError, "Payment frequency must be one of: monthly, quarterly, annually, maturity")
        end
      end
    end
  end
end 