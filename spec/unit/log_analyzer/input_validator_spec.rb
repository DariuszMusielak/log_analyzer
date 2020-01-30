# frozen_string_literal: true

shared_examples 'incorrect args' do |error_message|
  it { expect(subject).to eq(false) }

  it 'sets errors' do
    expect { subject }.to change { service.errors }.from([]).to([error_message])
  end
end

RSpec.describe LogAnalyzer::InputValidator do
  let(:service) { described_class.new }

  describe '#validate' do
    subject { service.validate(args) }

    context "when 'args' not set" do
      let(:args) { [] }

      it_behaves_like 'incorrect args', 'File path is required as a first argument.'
    end

    context "when 'args' set" do
      context 'when file_path incorrect type' do
        let(:args) { [1] }

        it_behaves_like 'incorrect args', "File doesn't exist for provided path."
      end

      context 'when args correct type' do
        context 'when file is missing' do
          let(:args) { ['/not_existing_file_path'] }

          it_behaves_like 'incorrect args', "File doesn't exist for provided path."
        end

        context 'when file is present' do
          let(:args) { ['spec/fixtures/webserver_short.log'] }

          it { expect(subject).to eq(true) }
        end
      end
    end

    context 'when optional args set' do
      let(:args) { ['spec/fixtures/webserver_short.log', optional_arg] }
      let(:optional_arg) { 'wrong' }

      context "when 'all' set" do
        let(:optional_arg) { 'all' }
        it { expect(subject).to eq(true) }
      end

      context "when 'visits' set" do
        let(:optional_arg) { 'visits' }
        it { expect(subject).to eq(true) }
      end

      context "when 'uniq_visits' set" do
        let(:optional_arg) { 'uniq_visits' }
        it { expect(subject).to eq(true) }
      end

      context 'when iuncorrect value set' do
        let(:optional_arg) { 'wrong' }
        it_behaves_like 'incorrect args',
                        'Second argument is allowed from the list: all, visits, uniq_visits.'
      end
    end
  end
end
