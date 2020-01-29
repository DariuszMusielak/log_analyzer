# frozen_string_literal: true

module LogAnalyzer
  class Presenter
    def call(results, analyze_type)
      description = fetch_description(analyze_type)

      results.each do |result|
        puts "#{result[:domain]} - #{result[:count]} #{description}"
      end
    end

    private

    def fetch_description(analyze_type)
      {
        visits: 'visits',
        uniq_visits: 'unique visits'
      }.fetch(analyze_type)
    end
  end
end
