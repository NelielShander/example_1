module Sorter
  class Transaction < Dry::Struct
    extend T::Sig

    attribute :timestamp, Types::String
    attribute :transaction_id, Types::String
    attribute :user_id, Types::String
    attribute :amount, Types::Coercible::Float

    sig { params(other: ::Sorter::Transaction).returns(T::Boolean) }
    def >=(other)
      amount >= other.amount
    end
  end
end
