# frozen_string_literal: true

module LogAnalyzer
  class InputValidator
    attr_reader :errors

    ALLOWED_ANALYZE_TYPES = %w[all visits uniq_visits].freeze
    private_constant :ALLOWED_ANALYZE_TYPES

    def initialize
      @errors = []
    end

    def validate(args)
      file_path_present?(args) && file_exisits?(args) && analyze_type_allowed?(args)
    end

    private

    attr_reader :args

    def analyze_type_allowed?(args)
      return true if args[1].nil? || ALLOWED_ANALYZE_TYPES.include?(args[1])

      @errors << LogAnalyzer.i18n('errors.incorrect_analyze_type')
      false
    end

    def file_path_present?(args)
      return true if args.any?

      @errors << LogAnalyzer.i18n('errors.missing_file_path')
      false
    end

    def file_exisits?(args)
      return true if args[0].is_a?(String) && File.exist?(args[0])

      @errors << LogAnalyzer.i18n('errors.file_missing')
      false
    end
  end
end
