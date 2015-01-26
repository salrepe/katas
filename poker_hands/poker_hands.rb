require 'rspec'
require_relative 'card'
require_relative 'hand'

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

describe PokerHands do
  describe '.play' do
    context 'for 2 given hand of cards' do
      it 'wins the player with the highest card' do
        hand_player1 = %w(2H 3D 5S 9C KD)
        hand_player2 = %w(2C 3H 4S 8C AH)

        expect(PokerHands.play(hand_player1, hand_player2)).to eq('White wins - with high card: A')
      end

      context 'when both hands have the same highest card' do
        it 'wins the hand with the second highest card' do
          hand_player1 = %w(2H 3D 5S 9C AD)
          hand_player2 = %w(2C 3H 4S 8C AH)

          expect(PokerHands.play(hand_player1, hand_player2)).to eq('Black wins - with high card: 9')
        end
      end

      context 'when both hands have the same cards values' do
        it 'the result is tie' do
          hand_player1 = %w(2H 3D 5S 9C AD)
          hand_player2 = %w(2C 3H 5S 9C AH)

          expect(PokerHands.play(hand_player1, hand_player2)).to eq('Tie')
        end
      end
    end
  end
end

