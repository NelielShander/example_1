require 'dry-struct'
require 'dry-monads'
require 'sorbet-runtime'

require_relative 'types'
require_relative 'sorter/transaction'
require_relative 'sorter/parser'

module Sorter
  extend T::Sig

  module_function

  PATH = File.dirname(__FILE__)

  sig { params(other: String).returns(String) }
  def call(file_name = nil)
    result = Parser.new(file_name: file_name).parse_file

    if result.success?
      result.success
    else
      result.failure
    end
  end
end
