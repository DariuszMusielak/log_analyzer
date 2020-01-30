# frozen_string_literal: true

RSpec.describe LogAnalyzer::Analyzer do
  let(:entries) do
    {
      '/about_page/1' => ['1111.2222.3333.4444', '1111.2222.3333.4444', '5555.2222.3333.4444'],
      '/user' => ['6666.2222.3333.4444', '5555.2222.3333.4444']
    }
  end

  describe '#call' do
    subject do
      described_class.new.call(entries, analyze_type)
    end

    context 'when `analyze_type` equals `:visits`' do
      let(:analyze_type) { :visits }
      let(:expected_results) do
        [
          { domain: '/about_page/1', result: 3 },
          { domain: '/user', result: 2 }
        ]
      end

      it { expect(subject).to eq(expected_results) }
    end

    context 'when `analyze_type` equals `:uniq_visits`' do
      let(:analyze_type) { :uniq_visits }
      let(:expected_results) do
        [
          { domain: '/about_page/1', result: 2 },
          { domain: '/user', result: 2 }
        ]
      end

      it { expect(subject).to eq(expected_results) }
    end
  end
end
