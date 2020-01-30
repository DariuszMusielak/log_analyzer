# frozen_string_literal: true

RSpec.describe LogAnalyzer::Repositories::Entries do
  describe '#count_entries' do
    subject { instance.count_entries(analyze_type) }
    let(:instance) do
      described_class['111.222.333.444', '111.222.333.444', '999.222.333.444']
    end

    context 'when `analyze_type` not defined' do
      let(:analyze_type) { nil }

      it { expect(subject).to eq(3) }
    end

    context 'when `analyze_type` equals `visits`' do
      let(:analyze_type) { 'visits' }

      it { expect(subject).to eq(3) }
    end

    context 'when `analyze_type` equals `uniq_visits`' do
      let(:analyze_type) { 'uniq_visits' }

      it { expect(subject).to eq(2) }
    end
  end
end
