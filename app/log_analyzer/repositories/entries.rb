# frozen_string_literal: true

module LogAnalyzer
  module Repositories
    class Entries < Array
      def count_entries(analyze_type = nil)
        case analyze_type.to_s
        when 'visits' then count
        when 'uniq_visits' then uniq.count
        else
          count
        end
      end
    end
  end
end
