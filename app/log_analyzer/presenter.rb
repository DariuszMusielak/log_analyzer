# frozen_string_literal: true

module LogAnalyzer
  class Presenter
    def call(results, analyze_type)
      description = LogAnalyzer.i18n(analyze_type)

      results.each do |result|
        puts "#{result[:domain]} - #{result[:count]} #{description}"
      end
    end
  end
end
