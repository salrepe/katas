require_relative 'high_card'
require_relative 'pair'

class Rank
  ORDER = [Pair, HighCard]

  def initialize(hand)
    @hand = hand
  end

  def > other
    return best > other.best if order == other.order

    order < other.order
  end

  def best
    @best ||= rankeables.detect { |rankeable| rankeable.exists? }
  end

  def order
    ORDER.index(best.class)
  end

  def result
    best.result
  end

  private

  def rankeables
    ORDER.map { |klass_name| klass_name.new(@hand.cards) }
  end
end
