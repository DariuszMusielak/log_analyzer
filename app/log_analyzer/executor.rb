# frozen_string_literal: true

module LogAnalyzer
  class Executor
    def initialize(input_validator = nil, processor = nil)
    def initialize(input_validator: nil, processor: nil)
      @input_validator = input_validator || InputValidator.new
      @processor = processor || Processor.new
    end

    def call(args)
      input_validator.validate(args) ? analyze(args) : print_errors
    end

    private

    attr_reader :input_validator, :processor

    def analyze(args)
      analyze_type = args[1]&.to_sym || :all

      case analyze_type
      when :all then analyze_all(args[0])
      when :visits then analyze_visits(args[0])
      when :uniq_visits then analyze_uniq_visits(args[0])
      end
    end

    def analyze_all(resource_to_analyze)
      analyze_visits(resource_to_analyze)
      analyze_uniq_visits(resource_to_analyze)
    end

    def analyze_visits(resource_to_analyze)
      processor.call(resource_to_analyze, :visits)
    end

    def analyze_uniq_visits(resource_to_analyze)
      processor.call(resource_to_analyze, :uniq_visits)
    end

    def print_errors
      print input_validator.errors.join(' ')
    end
  end
end
