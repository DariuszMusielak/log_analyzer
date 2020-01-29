# frozen_string_literal: true

module LogAnalyzer
  class Processor

    def initialize(reader = nil)
      @reader = reader || Reader
    end

    def call(file_path, analyze_type)
      @file_path = file_path
      @analyze_type = analyze_type
      @data = []
      load_data
      group_entries!
      sort_and_print
    end

    private

    attr_reader :data, :file_path, :analyze_type, :reader

    def load_data
      reader.new(file_path).each { |entry| @data << entry }
    end

    def sort_and_print
      results = {
        visits: sort_by_views,
        uniq_visits: sort_by_uniq_views
      }.fetch(analyze_type)

      print_results(results)
    end

    def group_entries!
      @data = data.group_by { |log_entry| log_entry[:domain] }
    end

    def sort_by_views
      data.map do |domain, ip|
        { domain: domain, count: ip.count }
      end.sort_by(&:values).reverse
    end

    def sort_by_uniq_views
      data.map do |domain, ip|
        { domain: domain, count: ip.uniq.count }
      end.sort_by(&:values).reverse
    end

    def print_results(results)
      description = (analyze_type == :visits ? 'visits' : 'unique visits')

      results.each { |result| puts "#{result[:domain]} - #{result[:count]} #{description}" }
    end
  end
end
