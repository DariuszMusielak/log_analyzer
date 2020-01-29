# frozen_string_literal: true

module LogAnalyzer
  class Presenter
    def call(results, analyze_type)
      description = (analyze_type == :visits ? 'visits' : 'unique visits')
      results.each { |result| puts "#{result[:domain]} - #{result[:count]} #{description}" }
    end
  end
end
