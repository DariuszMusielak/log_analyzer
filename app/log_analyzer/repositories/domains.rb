# frozen_string_literal: true

module LogAnalyzer
  module Repositories
    class Domains < Hash
      def add(domain_name, ip)
        self[domain_name] ? self[domain_name] << ip : self[domain_name] = [ip]
      end
    end
  end
end
