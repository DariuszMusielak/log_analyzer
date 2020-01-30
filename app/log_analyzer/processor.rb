# frozen_string_literal: true

module LogAnalyzer
  class Processor
    def initialize(reader: nil, sorter: nil, presenter: nil, repository: nil)
      @reader = reader || Reader
      @sorter = sorter || Sorter.new
      @repository = repository || Repositories::Domains
      @presenter = presenter || Presenter.new
    end

    def call(file_path, analyze_type)
      domain_repository = repository.new
      load_data(file_path, domain_repository)
      results = sort_data(domain_repository, analyze_type)
      print_results(results, analyze_type)
    end

    private

    attr_reader :reader, :sorter, :presenter, :repository

    def load_data(file_path, domain_repository)
      reader.new(file_path).read_entries { |domain_name, ip| domain_repository.add(domain_name, ip) }
    end

    def sort_data(domain_repository, analyze_type)
      sorter.call(domain_repository, analyze_type)
    end

    def print_results(results, analyze_type)
      presenter.call(results, analyze_type)
    end
  end
end
