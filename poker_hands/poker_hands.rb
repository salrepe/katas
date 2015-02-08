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

      obtain_winner(black, white).rank_result
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
  def rank_result
    'Tie'
  end
end

describe PokerHands do
  describe '.play' do
    context 'for 2 given hand of cards' do
      context 'with pairs in the hands' do
        it 'when a player has a pair and the other not, wins the player with the pair' do
          hand_black = %w(2H 2D 5S 9C KD)
          hand_white = %w(2C 3H 4S 8C AH)

          expect(PokerHands.play(hand_black, hand_white)).to eq('Black wins - with pair')

          hand_black = %w(2H 3D 5S 9C KD)
          hand_white = %w(3C 3H 4S 8C AH)

          expect(PokerHands.play(hand_black, hand_white)).to eq('White wins - with pair')
        end

        it 'when the 2 players have a pair wins the player with the pair with the highest cards in the pair' do
          hand_black = %w(2H 2D 5S 9C KD)
          hand_white = %w(3C 3H 4S 8C AH)

          expect(PokerHands.play(hand_black, hand_white)).to eq('White wins - with pair')

          hand_black = %w(5H 5D 6S 9C KD)
          hand_white = %w(3C 3H 4S 8C AH)

          expect(PokerHands.play(hand_black, hand_white)).to eq('Black wins - with pair')
        end

        it 'when the 2 players have a pair with the same values, wins the player with the high card of the rest of the cards' do
          hand_black = %w(2S 2D 5S 9C KD)
          hand_white = %w(2C 2S 4S 8C AH)

          expect(PokerHands.play(hand_black, hand_white)).to eq('White wins - with pair')

          hand_black = %w(5S 5D 6S 9C AD)
          hand_white = %w(5C 5H 4S 8C AH)

          expect(PokerHands.play(hand_black, hand_white)).to eq('Black wins - with pair')
        end
      end

      context 'with high card' do
        it 'wins the player with the highest card' do
          black_hand = %w(2H 3D 5S 9C KD)
          white_hand = %w(2C 3H 4S 8C AH)

          expect(PokerHands.play(black_hand, white_hand)).to eq('White wins - with high card: A')
        end

        context 'when both hands have the same highest card' do
          it 'wins the hand with the second highest card' do
            black_hand = %w(2H 3D 5S 9C AD)
            white_hand = %w(2C 3H 4S 8C AH)

            expect(PokerHands.play(black_hand, white_hand)).to eq('Black wins - with high card: 9')
          end
        end

        context 'when both hands have the same cards values' do
          it 'the result is tie' do
            black_hand = %w(2H 3D 5S 9C AD)
            white_hand = %w(2C 3H 5S 9C AH)

            expect(PokerHands.play(black_hand, white_hand)).to eq('Tie')
          end
        end
      end
    end
  end
end

