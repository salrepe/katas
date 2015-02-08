require_relative 'rank'

class Hand
  def initialize(name, representation)
    @name = name
    @cards = parse(representation)
  end

  attr_reader :cards

  def > other
    rank > other.rank
  end

  def rank
    @rank ||= Rank.new(self)
  end

  def rank_result
    "#{@name} wins - with #{@rank.result}"
  end

  private

  def parse(representation)
    representation.map { |h| Card.new(h) }
  end
end
