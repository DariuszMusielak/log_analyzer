# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LogAnalyzer::Reader do
  let(:file_path) { 'spec/fixtures/webserver_short.log' }
  let(:entries) { [] }
  let(:expected_entires_count) { 5 }
  let(:expected_domain) { '/test_page_2' }
  let(:expected_ip) { '111.222.333.444' }

  describe '#read_entries' do
    subject { described_class.new(file_path) }

    it 'reads entries from file' do
      subject.read_entries { |entry| entries << entry }

      expect(entries.count).to eq(expected_entires_count)
      expect(entries.first[:ip]).to eq(expected_ip)
      expect(entries.last[:domain]).to eq(expected_domain)
    end
  end
end
