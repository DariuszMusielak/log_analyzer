# frozen_string_literal: true

module LogAnalyzer
  class Sorter
    def call(domains_repository, analyze_type)
      sort(domains_repository, analyze_type)
    end

    private

    def sort(domains_repository, analyze_type)
      domains_repository.map do |domain_name, entries|
        { domain: domain_name, count: entries.count_entries(analyze_type) }
      end.sort_by(&:values).reverse
    end
  end
end
