class HighCard
  def initialize(cards)
    @cards = cards.sort.reverse
    @winner = nil
  end

  attr_reader :cards

  def > other
    cards.each_index do |index|
      if cards[index] > other.cards[index]
        @winner = cards[index]
        break
      end
    end
    !@winner.nil?
  end

  def rank
    "high card: #{@winner.value}"
  end
end
