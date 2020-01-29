# frozen_string_literal: true

require 'spec_helper'

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
      context 'when args incorrect type' do
        let(:args) { [1] }

        it_behaves_like 'incorrect args', "File doesn't exist for provided path."
      end

      context 'when args correct type' do
        context 'when file is missing' do
          let(:args) { ['/not_existing_file_path'] }

          it_behaves_like 'incorrect args', "File doesn't exist for provided path."
        end

        context 'when file is present' do
          let(:args) { ['spec/fixtures/webserver.log'] }

          it { expect(subject).to eq(true) }
        end
      end
    end
  end
end
