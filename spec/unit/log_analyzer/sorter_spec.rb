# frozen_string_literal: true

require 'spec_helper'

shared_examples 'returns correct results' do
  it { expect(subject).to eq(expected_sorter_results) }
end

RSpec.describe LogAnalyzer::Sorter do
  let(:entries) do
    [
      { domain: '/help_page/1', ip: '126.318.035.038' },
      { domain: '/help_page/1', ip: '184.123.665.067' },
      { domain: '/contact', ip: '184.123.665.067' },
      { domain: '/contact', ip: '184.123.665.067' },
      { domain: '/contact', ip: '126.318.035.038' }
    ]
  end

  describe '#call' do
    subject { described_class.new.call(entries, analyze_type) }

    context "when 'analyze_type' equals :visits" do
      let(:analyze_type) { :visits }
      let(:expected_sorter_results) do
        [
          { domain: '/help_page/1', count: 3 },
          { domain: '/contact', count: 2 }
        ]
      end
    end

    context "when 'analyze_type' equals :uniq_visits" do
      let(:analyze_type) { :uniq_visits }
      let(:expected_sorter_results) do
        [
          { domain: '/help_page/1', count: 2 },
          { domain: '/contact', count: 2 }
        ]
      end

      it_behaves_like 'returns correct results'
    end
  end
end
