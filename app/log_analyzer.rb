# frozen_string_literal: true

module LogAnalyzer
  class << self

    def i18n(key_chain)
      dictionary.get(key_chain)
    end

    private

    def dictionary
      @dictionary ||= Dictionary.new
    end
  end
end
