# frozen_string_literal: true

RSpec.describe LogAnalyzer do
  describe '#i18n' do
    subject { LogAnalyzer.i18n(key_chain) }
    let(:key_chain) { 'looking.for.a.word' }

    let(:dictionary_double) { instance_double('Dictionary', get: true) }

    before do
      allow(LogAnalyzer).to receive(:dictionary).and_return(dictionary_double)
    end

    it 'triggers proper method on dicsionary' do
      expect(dictionary_double).to receive(:get).with(key_chain).once
      subject
    end
  end
end
