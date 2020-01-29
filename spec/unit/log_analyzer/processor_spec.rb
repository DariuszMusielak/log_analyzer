# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LogAnalyzer::Processor do
  let(:file_path) { 'spec/fixtures/webserver.log' }
  let(:analyze_type) { nil }

  describe '#call' do
    subject { described_class.new.call(file_path, analyze_type) }

    context "when 'analyze_type' is defined as :visits" do
      let(:analyze_type) { :visits }

      it do
        expect { subject }.to output(
          <<~TEXT
            /index - 82 visits
            /home - 78 visits
            /help_page/1 - 80 visits
            /contact - 89 visits
            /about/2 - 90 visits
            /about - 81 visits
          TEXT
        ).to_stdout
      end
    end

    context "when 'analyze_type' is defined as unique_visits" do
      let(:analyze_type) { :uniq_visits }

      it do
        expect { subject }.to output(
          <<~TEXT
            /index - 23 unique visits
            /home - 23 unique visits
            /help_page/1 - 23 unique visits
            /contact - 23 unique visits
            /about/2 - 22 unique visits
            /about - 21 unique visits
          TEXT
        ).to_stdout
      end
    end
  end
end
