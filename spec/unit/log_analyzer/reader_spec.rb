# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LogAnalyzer::Reader do
  let(:file_path) { 'spec/fixtures/webserver.log' }
  let(:entries) { [] }
  let(:expected_entires_count) { 500 }
  let(:expected_domain) { '/about' }
  let(:expected_ip) { '126.318.035.038' }

  describe '#each' do
    subject { described_class.new(file_path) }

    it "reads entries from file" do
      subject.each { |entry| entries << entry }

      expect(entries.count).to eq(expected_entires_count)
      expect(entries.first[:ip]).to eq(expected_ip)
      expect(entries.last[:domain]).to eq(expected_domain)
    end
  end
end
