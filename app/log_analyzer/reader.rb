# frozen_string_literal: true

module LogAnalyzer
  class Reader
    attr_reader :file_path

    def initialize(file_path)
      @file_path = file_path
    end

    def read_entries(&block)
      File.open(file_path, 'r') do |file|
        file.each do |line|
          domain_name, ip = line.split(' ')
          block.call(domain_name, ip)
        end
      end
    end
  end
end
