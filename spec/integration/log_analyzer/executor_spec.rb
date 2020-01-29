# frozen_string_literal: true

require 'spec_helper'

shared_examples 'displays error message' do |error_message|
  it { expect { subject }.to output(error_message).to_stdout }
end

RSpec.describe LogAnalyzer::Executor do
  let(:args) { [file_path] }
  let(:file_path) { 'spec/fixtures/webserver.log' }

  describe '#call' do
    subject { described_class.new.call(args) }

    it do
      expect { subject }.to output(
        <<~TEXT
          /index - 82 visits
          /home - 78 visits
          /help_page/1 - 80 visits
          /contact - 89 visits
          /about/2 - 90 visits
          /about - 81 visits
          /index - 23 unique visits
          /home - 23 unique visits
          /help_page/1 - 23 unique visits
          /contact - 23 unique visits
          /about/2 - 22 unique visits
          /about - 21 unique visits
        TEXT
      ).to_stdout
    end

    context 'when arguments are incorrect' do
      context 'when file_path not passed' do
        let(:args) { [nil] }

        it_behaves_like 'displays error message', 'File path is required as a first argument.'
      end

      context 'when file does not exists' do
        let(:args) { ["not/existing/file/path"] }

        it_behaves_like 'displays error message', "File doesn't exist for provided path."
      end

      context 'when file_path is not a string' do
        let(:args) { [true] }

        it_behaves_like 'displays error message', "File doesn't exist for provided path."
      end
    end
  end
end
