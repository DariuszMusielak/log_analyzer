# frozen_string_literal: true

module LogAnalyzer
  class Reader
    attr_reader :file_path

    def initialize(file_path)
      @file_path = file_path
    end

    def each(&block)
      File.open(file_path, 'r') do |file|
        file.each_line do |line|
          domain, ip = line.split(' ')
          block.call(domain: domain, ip: ip)
        end
      end
    end
  end
end
