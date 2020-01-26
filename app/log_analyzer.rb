# frozen_string_literal: true

class LogAnalyzer
  attr_reader :file_path, :analyze_type, :data

  def initialize(file_path, analyze_type)
    @file_path = file_path
    @analyze_type = analyze_type
  end
  def call
  end
end
