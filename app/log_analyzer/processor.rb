# frozen_string_literal: true

module LogAnalyzer
  class Processor
    def initialize(analyzer: nil, presenter: nil, reader: nil, repository: nil, sorter: nil)
      @analyzer = analyzer || Analyzer.new
      @reader = reader || Reader
      @repository = repository || Repositories::Domains
      @presenter = presenter || Presenter.new
      @sorter = sorter || Sorter
    end

    def call(file_path, analyze_type)
      domain_repository = repository.new
      load_data(file_path, domain_repository)
      analyzed_data = analyze_data(domain_repository, analyze_type)
      sorted_data = sort_data(analyzed_data)
      print_results(sorted_data, analyze_type)
    end

    private

    attr_reader :reader, :sorter, :presenter, :repository, :analyzer

    def load_data(file_path, domain_repository)
      reader.new(file_path).read_entries { |domain_name, ip| domain_repository.add(domain_name, ip) }
    end

    def sort_data(analyze_data)
      sorter.sort(analyze_data, sort_direction: :desc)
    end

    def analyze_data(domain_repository, analyze_type)
      analyzer.call(domain_repository, analyze_type)
    end

    def print_results(results, analyze_type)
      presenter.call(results, analyze_type)
    end
  end
end
