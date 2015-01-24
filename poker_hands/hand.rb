class Hand
  def initialize(name, representation)
    @name = name
    @representation = representation
    @best_rank = nil
  end

  attr_accessor :best_rank

  def cards
    @representation.map { |h| Card.new(h) }
  end

  def > other
    result = false
    high_card = HighCard.calculate(cards, other.cards)
    other.best_rank = high_card
    if cards.include?(high_card)
      @best_rank = high_card
      result = true
    end
    result
  end

  def rank
    "#{@name} wins - with high card: #{@best_rank.value}"
  end
end

describe Hand do
  describe '#cards' do
    it 'returns the colection of cards for the given hand' do
      representation = %w(2H 3D 5S 9C KD)
      name = 'Black'
      hand = Hand.new(name, representation)

      expect(hand.cards).to eq([Card.new('2H'), Card.new('3D'), Card.new('5S'), Card.new('9C'), Card.new('KD')])
    end
  end
end
