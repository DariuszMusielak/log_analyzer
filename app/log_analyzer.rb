# frozen_string_literal: true

class LogAnalyzer
  attr_reader :file_path, :analyze_type, :data

  def initialize(file_path, analyze_type)
    @file_path = file_path
    @data = []
    @analyze_type = analyze_type
  end

  def call
    load_data
    group_entries!
    sort_and_print
  end

  private

  def sort_and_print
    results = {
      visits: sort_by_views,
      uniq_visits: sort_by_uniq_views
    }.fetch(analyze_type)

    print_results(results)
  end

  def load_data
    File.open(file_path, 'r') do |file|
      file.each_line do |line|
        domain, ip = line.split(' ')
        @data << { domain: domain, ip: ip }
      end
    end
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
