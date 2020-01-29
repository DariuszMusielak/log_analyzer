# frozen_string_literal: true

shared_examples 'prints results with correct description' do
  it do
    expect { subject }.to output(expected_output).to_stdout
  end
end

RSpec.describe LogAnalyzer::Presenter do
  let(:results) do
    [
      { domain: '/help_page/1', count: 2 },
      { domain: '/contact', count: 3 }
    ]
  end

  describe '#call' do
    subject { described_class.new.call(results, analyze_type) }

    context "when 'analyze_type' is defined as :visits" do
      let(:analyze_type) { :visits }
      let(:expected_output) do
        <<~TEXT
          ----- Statistics for visits ----
          /help_page/1 - 2 visits
          /contact - 3 visits
        TEXT
      end

      it_behaves_like 'prints results with correct description'
    end

    context "when 'analyze_type' is defined as unique_visits" do
      let(:analyze_type) { :uniq_visits }
      let(:expected_output) do
        <<~TEXT
          ----- Statistics for unique visits ----
          /help_page/1 - 2 unique visits
          /contact - 3 unique visits
        TEXT
      end

      it_behaves_like 'prints results with correct description'
    end
  end
end
