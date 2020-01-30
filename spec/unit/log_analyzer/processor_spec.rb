# frozen_string_literal: true

shared_examples 'runs through whole processor' do
  it do
    expect(reader_double_class).to receive(:new)
      .with(file_path).and_return(reader_double)
    expect(reader_double).to receive(:read_entries)
      .and_yield(*entries[0])
      .and_yield(*entries[1])
      .and_yield(*entries[2])
    expect(analyzer_double).to receive(:call)
      .with(domain_repository_double, analyze_type).and_return(analyzed_data)
    expect(sorter_double_class).to receive(:sort)
      .with(analyzed_data, sort_direction: :desc).and_return(sorter_result)
    expect(presenter_double).to receive(:call)
      .with(sorter_result, analyze_type).and_return(true)
    subject
  end
end

RSpec.describe LogAnalyzer::Processor do
  let(:file_path) { 'spec/fixtures/webserver_short.log' }
  let(:reader_double_class) { class_double('LogAnalyzer::Reader', new: reader_double) }
  let(:reader_double) { instance_double('LogAnalyzer::Reader') }
  let(:sorter_double_class) { class_double('LogAnalyzer::Sorter', sort: sorter_result) }
  let(:analyzer_double) { instance_double('LogAnalyzer::Analyzer', call: analyzed_data) }
  let(:presenter_double) { instance_double('LogAnalyzer::Presenter', call: true) }
  let(:domain_repository_double) { instance_double('LogAnalyzer::Repositories::Domains', add: true) }
  let(:domain_repository_double_class) do
    class_double('LogAnalyzer::Repositories::Domains', new: domain_repository_double)
  end

  let(:entries) do
    [
      ['/help_page/1', '126.318.035.038'],
      ['/contact', '184.123.665.067'],
      ['/contact', '126.318.035.038']
    ]
  end

  before do
    allow(reader_double).to receive(:read_entries)
      .and_yield(*entries[0])
      .and_yield(*entries[1])
      .and_yield(*entries[2])
  end

  describe '#call' do
    subject do
      described_class.new(
        analyzer: analyzer_double,
        presenter: presenter_double,
        reader: reader_double_class,
        repository: domain_repository_double_class,
        sorter: sorter_double_class
      ).call(file_path, analyze_type)
    end

    context "when 'analyze_type' is defined as :visits" do
      let(:analyze_type) { :visits }
      let(:sorter_result) do
        [
          { domain: '/help_page/1', result: 2 },
          { domain: '/contact', result: 3 }
        ]
      end
      let(:analyzed_data) do
        [
          { domain: '/help_page/1', result: 2 },
          { domain: '/contact', result: 3 }
        ]
      end

      it_behaves_like 'runs through whole processor'
    end

    context "when 'analyze_type' is defined as unique_visits" do
      let(:analyze_type) { :uniq_visits }
      let(:sorter_result) do
        [
          { domain: '/help_page/1', result: 2 },
          { domain: '/contact', result: 2 }
        ]
      end
      let(:analyzed_data) do
        [
          { domain: '/help_page/1', result: 2 },
          { domain: '/contact', result: 2 }
        ]
      end

      it_behaves_like 'runs through whole processor'
    end
  end
end
