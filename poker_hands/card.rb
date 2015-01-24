class Card
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

