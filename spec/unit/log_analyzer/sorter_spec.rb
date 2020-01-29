# frozen_string_literal: true

require 'spec_helper'

shared_examples 'returns correct results' do
  it { expect(subject).to eq(expected_sorter_results) }
end

RSpec.describe LogAnalyzer::Sorter do
  let(:entries) do
    [
      { domain: '/about_page/1', ip: '111.318.999.038' },
      { domain: '/about_page/1', ip: '945.127.665.532' },
      { domain: '/user', ip: '945.127.665.532' },
      { domain: '/user', ip: '945.127.665.532' },
      { domain: '/user', ip: '111.318.999.038' }
    ]
  end

  describe '#call' do
    subject { described_class.new.call(entries, analyze_type) }

    context "when 'analyze_type' equals :visits" do
      let(:analyze_type) { :visits }
      let(:expected_sorter_results) do
        [
          { domain: '/about_page/1', count: 3 },
          { domain: '/user', count: 2 }
        ]
      end
    end

    context "when 'analyze_type' equals :uniq_visits" do
      let(:analyze_type) { :uniq_visits }
      let(:expected_sorter_results) do
        [
          { count: 2, domain: '/user' },
          { count: 2, domain: '/about_page/1' }
        ]
      end

      it_behaves_like 'returns correct results'
    end
  end
end
