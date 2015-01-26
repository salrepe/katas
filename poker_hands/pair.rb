class Pair
  PAIR_COUNT = 2

  def self.calculate(black_cards, white_cards)
    new(black_cards, white_cards).calculate
  end

  def initialize(black_cards, white_cards)
    @black_cards = black_cards
    @white_cards = white_cards
    @paired_black_card = paired_card(@black_cards)
    @paired_white_card = paired_card(@white_cards)
  end

  def calculate
    if both_hands_with_pair?
      look_for_high_card
    else
      paired_card_in_black_or_white_cards
    end
  end

  private

  def paired_card(cards)
    cards_values = cards.map(&:value)
    cards.detect do |c|
      cards_values.count(c.value) == PAIR_COUNT
    end
  end

  def both_hands_with_pair?
    @paired_black_card && @paired_white_card
  end

  def look_for_high_card
    if both_hands_with_same_pair?
      higest_card_between_the_rest
    else
      pair_with_higest_card
    end
  end

  def paired_card_in_black_or_white_cards
    @paired_black_card || @paired_white_card
  end

  def both_hands_with_same_pair?
    @paired_black_card.value == @paired_white_card.value
  end

  def pair_with_higest_card
    high_card([@paired_black_card], [@paired_white_card])
  end

  def higest_card_between_the_rest
    black_cards = remove_cards_with_value(@black_cards, @paired_black_card.value)
    white_cards = remove_cards_with_value(@white_cards, @paired_white_card.value)
    high_card(black_cards, white_cards)
  end

  def remove_cards_with_value(cards, paired_card_value)
    cards.select { |c| c.value != paired_card_value }
  end

  def high_card(black_cards, white_cards)
    HighCard.calculate(black_cards, white_cards)
  end
end
