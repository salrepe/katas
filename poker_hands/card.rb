class Card
  CARDS_ORDER = %w(2 3 4 5 6 7 8 9 T J Q K A)

  def initialize(name)
    @name = name
  end

  attr_reader :name

  def suit
    @name[1]
  end

  def value
    @name[0]
  end

  def == (other_card)
    return false unless other_card
    (suit == other_card.suit) && (value == other_card.value)
  end

  def > other
    CARDS_ORDER.index(value) > CARDS_ORDER.index(other.value)
  end

  def < other
    CARDS_ORDER.index(value) < CARDS_ORDER.index(other.value)
  end

  def <=> other
    return 0 if self == other
    return -1 if self < other
    return 1 if self > other
  end
end

describe Card do
  describe '#suit' do
    it 'returns the suit of the card' do
      card = Card.new('2H')
      expect(card.suit).to eq('H')
    end
  end

  describe '#value' do
    it 'returns the value of the card' do
      card = Card.new('2H')
      expect(card.value).to eq('2')
    end
  end
end

