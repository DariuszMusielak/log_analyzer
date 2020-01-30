# frozen_string_literal: true

module LogAnalyzer
  class Sorter
    class << self
      def sort(data, sort_direction: nil)
        case sort_direction
        when :asc  then default_sort(data)
        when :desc then default_sort(data).reverse
        else
          default_sort(data)
        end
      end

      private

      def default_sort(data)
        data.sort_by { |result| result[:result] }
      end
    end
  end
end
