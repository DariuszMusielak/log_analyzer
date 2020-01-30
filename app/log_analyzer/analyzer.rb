# frozen_string_literal: true

module LogAnalyzer
  class Analyzer
    def call(domains_repository, analyze_type)
      calculate(analyze_type, domains_repository)
    end

    private

    def calculate(analyze_type, domains_repository)
      case analyze_type
      when :visits then visits_count(domains_repository)
      when :uniq_visits then uniq_visits_count(domains_repository)
      end
    end

    def visits_count(domains_repository)
      domains_repository.map do |domain, entries|
        { domain: domain, result: entries.count }
      end
    end

    def uniq_visits_count(domains_repository)
      domains_repository.map do |domain, entries|
        { domain: domain, result: entries.uniq.count }
      end
    end
  end
end
