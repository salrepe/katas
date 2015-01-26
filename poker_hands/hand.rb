class Hand
  def initialize(name, representation)
    @name = name
    @cards = parse(representation)
    @best_rank = nil
  end

  attr_accessor :best_rank
  attr_reader :cards

  def > other
    @best_rank = evaluate_high_card(other)
    !@best_rank.nil?
  end

  def rank
    "#{@name} wins - with high card: #{@best_rank.value}"
  end

  def evaluate_high_card(other)
    winner = nil
    cards.each_index do |index|
      if cards[index] > other.cards[index]
        winner = cards[index]
        break
      end
    end
    winner
  end

  private

  def parse(representation)
    representation.map { |h| Card.new(h) }.sort.reverse
  end
end
