require_relative  '../cli'
require 'stringio'

RSpec.describe Deposit do
  def capture_output
    original_stdout = $stdout
    $stdout = StringIO.new
    begin
      yield
      $stdout.string
    ensure
      $stdout = original_stdout
    end
  end

  describe '#final_balance' do
    context 'with valid input' do
      it 'prints the final balance' do
        output = capture_output do
          described_class.start([
            'calculate',
            '--amount', '1000',
            '--rate', '1.1',
            '--term', '12',
            '--frequency', 'maturity'
          ])
        end

        expect(output).to include('Final balance:')
      end

      it 'uses defaults when optional arguments are omitted' do
        output = capture_output do
          described_class.start(['calculate', '--amount', '2000'])
        end
        expect(output).to include('Final balance:')
      end
    end

    it 'shows help with --help flag' do
      output = capture_output do
        described_class.start(['calculate', '--help'])
      end
      expect(output).to include('calculate').and include("Earned on a term deposit")
    end

    it 'exits with error when amount is missing' do
      output = capture_output do
        expect {
          described_class.start(['calculate'])
        }.to raise_error(SystemExit)
      end
      
      expect(output).to include('Error: --amount is required')
    end

    it 'exits with error when frequency is invalid' do
      expect {
        capture_output do
          described_class.start([
            'calculate',
            '--amount', '1000',
            '--frequency', 'weekly'
          ])
        end
      }.to raise_error(SystemExit)
    end
    
    it 'handles unexpected errors gracefully' do
      allow(Calculator).to receive(:new).and_raise(StandardError.new("foo"))

      output = capture_output do
        expect {
          described_class.start([
            'calculate',
            '--amount', '1000'
          ])
        }.to raise_error(SystemExit)
      end

      expect(output).to include('❌ An error occurred: foo')
    end

    it 'exits on failure' do
      expect(described_class.exit_on_failure?).to be true
    end
  end
end
