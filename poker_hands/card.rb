class Card
  ORDER = %w(2 3 4 5 6 7 8 9 T J Q K A)

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

  def > (other_card)
    ORDER.index(value) > ORDER.index(other_card.value)
  end
end
