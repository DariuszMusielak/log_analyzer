# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LogAnalyzer::Processor do
  let(:file_path) { 'spec/fixtures/webserver_short.log' }
  let(:reader_double) { class_double('LogAnalyzer::Reader', new: logs) }
  let(:sorter_double) { instance_double('LogAnalyzer::Sorter', call: sorter_result) }

  let(:logs) do
    [
      { domain: '/help_page/1', ip: '126.318.035.038' },
      { domain: '/help_page/1', ip: '184.123.665.067' },
      { domain: '/contact', ip: '184.123.665.067' },
      { domain: '/contact', ip: '184.123.665.067' },
      { domain: '/contact', ip: '126.318.035.038' }
    ]
  end

  describe '#call' do
    subject do
      described_class.new(
        reader: reader_double,
        sorter: sorter_double
      ).call(file_path, analyze_type)
    end

    context "when 'analyze_type' is defined as :visits" do
      let(:analyze_type) { :visits }
      let(:sorter_result) do
        [
          { domain: '/help_page/1', count: 2 },
          { domain: '/contact', count: 3 }
        ]
      end

      it do
        expect { subject }.to output(
          <<~TEXT
            /help_page/1 - 2 visits
            /contact - 3 visits
          TEXT
        ).to_stdout
      end
    end

    context "when 'analyze_type' is defined as unique_visits" do
      let(:analyze_type) { :uniq_visits }
      let(:sorter_result) do
        [
          { domain: '/help_page/1', count: 2 },
          { domain: '/contact', count: 2 }
        ]
      end

      it do
        expect { subject }.to output(
          <<~TEXT
            /help_page/1 - 2 unique visits
            /contact - 2 unique visits
          TEXT
        ).to_stdout
      end
    end
  end
end
