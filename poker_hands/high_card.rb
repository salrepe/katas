class HighCard
  CARDS_ORDER = %w(2 3 4 5 6 7 8 9 T J Q K A)

  def self.calculate(cards_hand1, cards_hand2)
    new(cards_hand1, cards_hand2).calculate
  end

  def initialize(cards_hand1, cards_hand2)
    @cards_hand1 = cards_hand1
    @cards_hand2 = cards_hand2
    @high_card_hand1 = calculate_highest_card_for(cards_hand1)
    @high_card_hand2 = calculate_highest_card_for(cards_hand2)
  end

  def calculate
    return unless high_card_hand1 || high_card_hand2

    if highest_card_in_both_hands?
      recalculate_high_card
    else
      highest_card
    end
  end

  private

  attr_reader :cards_hand1, :cards_hand2
  attr_reader :high_card_hand1, :high_card_hand2

  def highest_card_in_both_hands?
    highest_card_equal_to?(high_card_hand1) &&
      highest_card_equal_to?(high_card_hand2)
  end

  def recalculate_high_card
    self.class.calculate(
      remove_highest_card_from(cards_hand1),
      remove_highest_card_from(cards_hand2)
    )
  end

  def highest_card_equal_to?(card)
    highest_card.value == card.value
  end

  def remove_highest_card_from(cards)
    cards.reject do |card|
      card.value == highest_card.value
    end
  end

  def highest_card
    two_hands_higest_cards = [high_card_hand1, high_card_hand2]
    calculate_highest_card_for(two_hands_higest_cards)
  end

  def calculate_highest_card_for(cards)
    cards.sort_by do |card|
      CARDS_ORDER.index(card.value)
    end.last
  end
end
