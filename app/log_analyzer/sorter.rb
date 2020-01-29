# frozen_string_literal: true

module LogAnalyzer
  class Sorter
    def call(entries, analyze_type)
      grouped_entries = group(entries)
      sort(analyze_type, grouped_entries)
    end

    private

    def sort(analyze_type, grouped_entries)
      {
        visits: sort_by_views(grouped_entries),
        uniq_visits: sort_by_uniq_views(grouped_entries)
      }.fetch(analyze_type)
    end

    def group(entries)
      entries.group_by { |log_entry| log_entry[:domain] }
    end

    def sort_by_views(grouped_entries)
      grouped_entries.map do |domain, ip|
        { domain: domain, count: ip.count }
      end.sort_by(&:values).reverse
    end

    def sort_by_uniq_views(grouped_entries)
      grouped_entries.map do |domain, ip|
        { domain: domain, count: ip.uniq.count }
      end.sort_by(&:values).reverse
    end
  end
end
