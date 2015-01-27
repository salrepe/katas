require_relative 'high_card'

class Hand
  def initialize(name, representation)
    @name = name
    @cards = parse(representation)
    @best_rank = nil
  end

  attr_reader :cards

  def > other
    high_card > other.high_card
  end

  def rank
    "#{@name} wins - with #{high_card.rank}"
  end

  def high_card
    @high_card ||= HighCard.new(self.cards)
  end

  private

  def parse(representation)
    representation.map { |h| Card.new(h) }
  end
end
