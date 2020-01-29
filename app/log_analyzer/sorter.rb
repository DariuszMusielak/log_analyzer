# frozen_string_literal: true

module LogAnalyzer
  class Sorter
    attr_reader :entries, :analyze_type

    def call(entires, analyze_type)
      grouped_entires = group(entires)
      domains_with_entires = count(grouped_entires, analyze_type)
      sort(domains_with_entires)
    end

    private

    def sort(domains_with_entires)
      domains_with_entires.sort_by(&:values).reverse
    end

    def group(entires)
      entires.group_by { |entry| entry[:domain] }
    end

    def count(grouped_entires, analyze_type)
      grouped_entires.map do |domain, ips|
        { domain: domain, count: count_entires(ips, analyze_type) }
      end
    end

    def count_entires(ips, analyze_type)
      case analyze_type
      when :visits then ips.count
      when :uniq_visits then ips.uniq.count
      end
    end
  end
end
