require_relative 'pair'

class Hand
  def initialize(name, representation)
    @name = name
    @representation = representation
    @best_rank = nil
  end

  def cards
    @representation.map { |h| Card.new(h) }
  end

  def > other
    @pair = Pair.calculate(cards, other.cards)
    @best_rank = @pair
    @best_rank = HighCard.calculate(cards, other.cards) unless @best_rank
    cards.include?(@best_rank)
  end

  def rank
    if @pair
      "#{@name} wins - with pair"
    else
      "#{@name} wins - with high card: #{@best_rank.value}"
    end
  end
end
