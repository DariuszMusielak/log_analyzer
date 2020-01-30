# frozen_string_literal: true

require 'yaml'

# TODO: Devide dictionary on 3 separate services,
# one for validaitng selected language
# second for loading dictionry
# third for handling finding wording for passed arguments

class Dictionary
  DEFAULT_LANGUAGE = :en
  KEYS_DELIMETER = '.'
  DICTIONARIES = [:en].freeze

  attr_reader :dictionary

  def initialize(language: nil)
    @language = language || DEFAULT_LANGUAGE
    language_allowed?
    @dictionary = preload_dictionary
  end

  def get(key_chain)
    dictionary.dig(*key_chain.to_s.split(KEYS_DELIMETER))
  end

  private

  attr_reader :language

  def language_allowed?
    return if DICTIONARIES.include?(language)

    raise ArgumentError, "Allowed dictionaries are: #{DICTIONARIES.join(', ')}"
  end

  def preload_dictionary
    YAML.safe_load(
      File.read(dictionary_file_path)
    )
  end

  def dictionary_file_path
    main_directory = Dir.glob('*').first
    "#{main_directory}/dictionaries/#{language}.yml"
  end
end
