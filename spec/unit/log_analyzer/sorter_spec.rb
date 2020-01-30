# frozen_string_literal: true

RSpec.describe LogAnalyzer::Sorter do
  describe '#call' do
    subject { described_class.sort(entries, sort_direction: sort_direction) }

    let(:entries) do
      [
        { domain: '/about_page/1', result: 5 },
        { domain: '/user', result: 3 },
        { domain: '/help', result: 8 }
      ]
    end

    context 'when `sort_direction` set to `:decs`' do
      let(:sort_direction) { :desc }
      let(:expected_sorter_results) do
        [
          { domain: '/help', result: 8 },
          { domain: '/about_page/1', result: 5 },
          { domain: '/user', result: 3 }
        ]
      end

      it { expect(subject).to eq(expected_sorter_results) }
    end

    context 'when `sort_direction` set to `:asc`' do
      let(:sort_direction) { :asc }
      let(:expected_sorter_results) do
        [
          { domain: '/user', result: 3 },
          { domain: '/about_page/1', result: 5 },
          { domain: '/help', result: 8 }
        ]
      end

      it { expect(subject).to eq(expected_sorter_results) }
    end

    context 'when `sort_direction` not specified' do
      let(:sort_direction) { nil }
      let(:expected_sorter_results) do
        [
          { domain: '/user', result: 3 },
          { domain: '/about_page/1', result: 5 },
          { domain: '/help', result: 8 }
        ]
      end

      it { expect(subject).to eq(expected_sorter_results) }
    end
  end
end
