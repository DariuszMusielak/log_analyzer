# frozen_string_literal: trueś

shared_examples 'displays error message' do |error_message|
  it { expect { subject }.to output(error_message).to_stdout }
end

RSpec.describe LogAnalyzer::Executor do
  let(:args) { [file_path] }
  let(:file_path) { 'spec/fixtures/webserver_short.log' }

  describe '#call' do
    subject { described_class.new.call(args) }

    it do
      expect { subject }.to output(
        <<~TEXT
          ----- Statistics for visits ----
          /test_page_2 - 3 visits
          /test_page_1/1 - 2 visits
          ----- Statistics for unique visits ----
          /test_page_2 - 2 unique visits
          /test_page_1/1 - 2 unique visits
        TEXT
      ).to_stdout
    end

    context 'when arguments are incorrect' do
      context 'when file_path not passed' do
        let(:args) { [nil] }

        it_behaves_like 'displays error message', 'File path is required as a first argument.'
      end

      context 'when file does not exist' do
        let(:args) { ['not/existing/file/path'] }

        it_behaves_like 'displays error message', "File doesn't exist for provided path."
      end

      context 'when file_path is not a string' do
        let(:args) { [true] }

        it_behaves_like 'displays error message', "File doesn't exist for provided path."
      end

      context 'when optional argument incorrect' do
        let(:args) { [file_path, 'incorrect'] }
        it_behaves_like 'displays error message',
                        'Second argument is allowed from the list: all, visits, uniq_visits.'
      end
    end
  end
end
