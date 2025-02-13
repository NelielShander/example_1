require 'sorbet-runtime'

module WordChecker
  extend T::Sig
  extend self

  sig { params(string: String, dictionary: Array).returns(T::Boolean) }
  def call(string:, dictionary:)
    match = dictionary.map { |word| string.scan(word) }
    match.join.chars.sort == string.chars.sort
  end
end
