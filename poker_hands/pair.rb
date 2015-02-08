class Pair
  PARITY = 2

  def initialize(cards)
    @cards = cards
  end

  attr_reader :cards

  def exists?
    !!paired_card
  end

  def > other
    if paired_card == other.paired_card
      return true if HighCard.new(cards) > HighCard.new(other.cards)
    end
    paired_card > other.paired_card
  end

  def result
    'pair'
  end

  def paired_card
    @paired_card ||= @cards.detect { |card| @cards.count(card) == PARITY }
  end
end
