require 'rspec'
require 'tempfile'
require_relative '../lib/sorter'

RSpec.describe 'Sorter' do
  before do
    Tempfile.new
    file = File.new(unsorted_path, 'w')
    lines_count.times do
      line = [DateTime.now, "txn#{rand(1000..9999)}", "user##{rand(1000..9999)}", rand(0.9..999.9)&.round(2)].join(',')
      file.puts(line)
    end
    file.close
  end

  after do
    File.delete(unsorted_path) if File.exist?(unsorted_path)
    File.delete(sorted_path) if File.exist?(sorted_path)
  end

  describe '.call' do
    subject { Sorter }
    let(:unsorted_path) { File.join(Sorter::PATH, '../unsorted.csv') }
    let(:sorted_path) { File.join(Sorter::PATH, '../sorted.csv') }
    let(:lines_count) { 10 }

    it 'creates a sorted transaction file' do
      result = subject.call
      amounts = []
      IO.foreach(sorted_path, chomp: true) { |line| amounts << line.split(',').last.to_f }

      expect(result).to eq('Sorting successfully!')
      expect(amounts.sort.reverse).to eq(amounts)
    end
  end
end
