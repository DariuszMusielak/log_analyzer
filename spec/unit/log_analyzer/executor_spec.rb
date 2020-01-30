# frozen_string_literal: true

RSpec.describe LogAnalyzer::Executor do
  subject do
    described_class.new(
      input_validator: input_validator_double,
      processor: processor_double
    ).call(args)
  end
  let(:args) { [file_path] }
  let(:file_path) { 'spec/fixtures/webserver_short.log' }

  let(:input_validator_double) do
    instance_double('LogAnalyzer::InputValidator', validate: valid, errors: errors)
  end
  let(:processor_double) { instance_double('LogAnalyzer::Processor', call: true) }
  let(:valid) { true }
  let(:errors) { ['some error'] }

  describe '#call' do
    it 'validates args' do
      expect(input_validator_double).to receive(:validate).with(args).and_return(valid)
      subject
    end

    context 'when args valid' do
      context 'when analyze all' do
        it 'calls log analyzer' do
          expect(processor_double).to receive(:call).with(file_path, :visits).once
          expect(processor_double).to receive(:call).with(file_path, :uniq_visits).once
          subject
        end
      end

      context 'when analyze only visits' do
        let(:args) { [file_path, 'visits'] }
        it 'calls log analyzer' do
          expect(processor_double).to receive(:call).with(file_path, :visits).once
          subject
        end
      end

      context 'when analyze unique visits' do
        let(:args) { [file_path, 'uniq_visits'] }

        it 'calls log analyzer' do
          expect(processor_double).to receive(:call).with(file_path, :uniq_visits).once
          subject
        end
      end
    end

    context 'when args invalid' do
      let(:valid) { false }

      it { expect { subject }.to output(errors.first).to_stdout }
    end
  end
end
