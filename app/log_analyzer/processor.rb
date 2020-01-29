# frozen_string_literal: true

module LogAnalyzer
  class Processor
    def initialize(reader: nil, sorter: nil)
      @reader = reader || Reader
      @sorter = sorter || Sorter.new
    end

    def call(file_path, analyze_type)
      @analyze_type = analyze_type
      @data = []
      load_data(file_path)
      results = sort_data(analyze_type)
      print_results(results, analyze_type)
    end

    private

    attr_reader :data, :reader, :sorter

    def load_data(file_path)
      reader.new(file_path).each { |entry| @data << entry }
    end

    def sort_data(analyze_type)
      sorter.call(data, analyze_type)
    end

    def print_results(results, analyze_type)
      description = (analyze_type == :visits ? 'visits' : 'unique visits')

      results.each { |result| puts "#{result[:domain]} - #{result[:count]} #{description}" }
    end
  end
end
