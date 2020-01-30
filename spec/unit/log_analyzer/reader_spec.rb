# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LogAnalyzer::Reader do
  let(:file_path) { 'spec/fixtures/webserver_short.log' }
  let(:expected_domains_count) { 5 }
  let(:expected_domain) { '/test_page_1/1' }
  let(:expected_ip) { '111.222.333.444' }
  let(:entries) { [] }

  describe '#read_entries' do
    subject { described_class.new(file_path) }

    it 'reads entries from file' do
      subject.read_entries { |domain_name, ip| entries << { domain: domain_name, ip: ip } }

      expect(entries.count).to eq(expected_domains_count)
      expect(entries.first[:domain]).to eq(expected_domain)
      expect(entries.first[:ip]).to eq(expected_ip)
    end
  end
end
