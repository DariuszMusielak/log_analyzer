# frozen_string_literal: true

module LogAnalyzer
  class InputValidator
    attr_reader :errors

    def initialize
      @errors = []
    end

    def validate(args)
      present?(args) && correct?(args)
    end

    private

    attr_reader :args

    def present?(args)
      return true if args.any?

      @errors << 'File path is required as a first argument.'
      false
    end

    def correct?(args)
      return true if args[0].is_a?(String) && File.exist?(args[0])

      @errors << "File doesn't exist for provided path."
      false
    end
  end
end
