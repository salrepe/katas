class HighCard
  def self.calculate(cards_black, cards_white)
    new(cards_black, cards_white).calculate
  end

  def initialize(cards_black, cards_white)
    @cards_black = cards_black
    @cards_white = cards_white
    @high_card_black = calculate_highest_card_for(cards_black)
    @high_card_white = calculate_highest_card_for(cards_white)
  end

  def calculate
    return unless high_card_black || high_card_white

    if highest_card_in_both_hands?
      recalculate_high_card
    else
      highest_card
    end
  end

  private

  attr_reader :cards_black, :cards_white
  attr_reader :high_card_black, :high_card_white

  def highest_card_in_both_hands?
    highest_card_equal_to?(high_card_black) &&
      highest_card_equal_to?(high_card_white)
  end

  def recalculate_high_card
    self.class.calculate(
      remove_highest_card_from(cards_black),
      remove_highest_card_from(cards_white)
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
    two_hands_higest_cards = [high_card_black, high_card_white]
    calculate_highest_card_for(two_hands_higest_cards)
  end

  def calculate_highest_card_for(cards)
    highest_card = cards.first
    cards.each do |card|
      highest_card = card if card > highest_card
    end
    highest_card
  end
end
