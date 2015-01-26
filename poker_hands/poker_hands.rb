require 'rspec'
require_relative 'card'
require_relative 'hand'
require_relative 'high_card'

class PokerHands
  BLACK = 'Black'
  WHITE = 'White'

  class << self
    def play(black_hand, white_hand)
      black = Hand.new(BLACK, black_hand)
      white = Hand.new(WHITE, white_hand)

      obtain_winner(black, white).rank
    end

    private

    def obtain_winner(black, white)
      winner = Tie.new
      winner = black if black > white
      winner = white if white > black
      winner
    end
  end
end

class Tie
  def rank
    'Tie'
  end
end
