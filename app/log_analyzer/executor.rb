# frozen_string_literal: true

module LogAnalyzer
  class Executor
    def initialize(input_validator = nil, processor = nil)
      @input_validator = input_validator || InputValidator.new
      @processor = processor || Processor.new
    end

    def call(args)
      input_validator.validate(args) ? analyze(args[0]) : print_errors
    end

    private

    attr_reader :input_validator, :processor

    def analyze(resource_to_analyze)
      processor.call(resource_to_analyze, :visits)
      processor.call(resource_to_analyze, :uniq_visits)
    end

    def print_errors
      print input_validator.errors.join(' ')
    end
  end
end
