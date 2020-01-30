# frozen_string_literal: true

RSpec.describe Dictionary do
  let(:file_path) { 'spec/fixtures/dictionary/en.yml' }

  context 'when unknow language set' do
    subject { described_class.new(language: :unknown) }

    it { expect { subject }.to raise_error(ArgumentError) }
  end

  describe '#get' do
    subject { described_class.new.get(key_chain) }

    before do
      allow(YAML).to receive(:safe_load).and_return(dictionary_hash)
    end

    let(:dictionary_hash) do
      { 'errors' => { 'test' => 'test error' } }
    end

    context 'when wording exists for key_chain' do
      let(:key_chain) { 'errors.test' }

      it { expect(subject).to eq('test error') }
    end

    context "when wording doesn't exist for key_chain" do
      let(:key_chain) { 'unknown' }

      it { expect(subject).to be_nil }
    end
  end
end
