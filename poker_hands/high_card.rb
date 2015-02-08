class HighCard
  def initialize(cards)
    @cards = cards.sort.reverse
  end

  attr_reader :cards

  def > other
    !!highest_card(other)
  end

  def exists?
    true
  end

  def result
    "high card: #{@highest_card.value}"
  end

  private

  def highest_card(other)
    @highest_card ||= @cards.detect do |card|
      index = cards.index(card)
      cards[index] > other.cards[index]
    end
  end
end
