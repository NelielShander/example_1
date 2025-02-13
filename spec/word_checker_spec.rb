require 'rspec'
require_relative '../lib/word_checker'

RSpec.describe 'WordChecker' do
  describe '.call' do
    subject { WordChecker }
    let(:string) { 'двадесятка' }
    let(:dictionary) { %w[десятка два девятка] }
    let(:wrong_dictionary) { %w[десятка три девятка] }

    it 'check substring truthy' do
      result = subject.call(string:, dictionary:)
      expect(result).to be_truthy
    end

    it 'check substring truthy' do
      result = subject.call(string:, dictionary: wrong_dictionary)
      expect(result).to be_falsey
    end

    it 'call String#scan exactly times' do
      expect(string).to receive(:scan).exactly(dictionary.size).times
      subject.call(string:, dictionary:)
    end
  end
end
