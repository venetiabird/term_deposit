require 'calculator'


RSpec.describe Calculator do
  let(:payment_frequency) { :maturity }
  let(:inputs) { { amount: 10000, interest_rate: 1.1, term: 36, payment_frequency: payment_frequency } }

  subject { described_class.new(inputs) }
  describe '#final_balance' do
    context 'when the interest paid at maturity' do
      it 'returns a final amount for the term' do
        expect(subject.final_balance[:final_amount]).to eq(10330)
        expect(subject.final_balance[:interest]).to eq(330)
      end
    end

    context 'when the interest paid monthly' do
      let(:payment_frequency) { :monthly}
      it 'returns a final amount for the term' do
        expect(subject.final_balance[:final_amount]).to eq(10335)
        expect(subject.final_balance[:interest]).to eq(335)
      end
    end

    context 'when the interest paid quarterly' do
      let(:payment_frequency) { :quarterly}
      it 'returns a final amount for the term' do
        expect(subject.final_balance[:final_amount]).to eq(10335)
        expect(subject.final_balance[:interest]).to eq(335)
      end
    end

     context 'when the interst paid anually' do
      let(:payment_frequency) { :annually}
      it 'returns a final amount for the term' do
        expect(subject.final_balance[:final_amount]).to eq(10334)
        expect(subject.final_balance[:interest]).to eq(334)
      end
    end
  end
end