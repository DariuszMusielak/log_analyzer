# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LogAnalyzer::Sorter do
  let(:entries) do
    {
      '/about_page/1' => instance_double('LogAnalyzer::EntryRepository', count_entries: 2),
      '/user' => instance_double('LogAnalyzer::EntryRepository', count_entries: 3)
    }
  end

  describe '#call' do
    subject { described_class.new.call(entries, analyze_type) }

    let(:analyze_type) { :visits }
    let(:expected_sorter_results) do
      [
        { domain: '/user', count: 3 },
        { domain: '/about_page/1', count: 2 }
      ]
    end

    it { expect(subject).to eq(expected_sorter_results) }
  end
end
