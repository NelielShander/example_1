module Sorter
  class Parser < Dry::Struct
    extend T::Sig
    include Dry::Monads[:result]

    attribute :file_name, Types::Optional::String

    def parse_file
      src_path = file_name || File.join(Sorter::PATH, '../unsorted.csv')
      dst_path = File.join(Sorter::PATH, '../sorted.csv')
      tempfile = Tempfile.new

      IO.foreach(src_path, chomp: true) do |new_line|
        tempfile = add_new_line(tempfile, new_line)
      end

      IO.copy_stream(tempfile, dst_path)
      tempfile.unlink

      Success('Sorting successfully!')
    rescue => e
      Failure(e.message)
    end

    private

    def add_new_line(tempfile, new_line)
      new_tempfile = Tempfile.new
      is_added = false

      tempfile.each_line(chomp: true) do |temp_line|
        if new_transaction(new_line) >= new_transaction(temp_line) && !is_added
          new_tempfile.puts(new_line)
          is_added = true
        end

        new_tempfile.puts temp_line
      end

      new_tempfile.puts(new_line) unless is_added
      new_tempfile.rewind
      new_tempfile
    end

    def new_transaction(line)
      timestamp, transaction_id, user_id, amount = *line.split(',')
      ::Sorter::Transaction.new(timestamp:, transaction_id:, user_id:, amount:)
    end
  end
end
