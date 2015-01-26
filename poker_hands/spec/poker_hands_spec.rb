require_relative '../poker_hands'

describe PokerHands do
  describe '.play' do
    context 'for 2 given hand of cards' do
      context 'with pairs in the hands' do
        it 'when a player has a pair and the other not, wins the player with the pair' do
          hand_black = %w(2h 2D 5S 9C KD)
          hand_white = %w(2C 3H 4S 8C AH)

          expect(PokerHands.play(hand_black, hand_white)).to eq('Black wins - with pair')

          hand_black = %w(2h 3D 5S 9C KD)
          hand_white = %w(3C 3H 4S 8C AH)

          expect(PokerHands.play(hand_black, hand_white)).to eq('White wins - with pair')
        end

        it 'when the 2 players have a pair wins the player with the pair with the highest cards' do
          hand_black = %w(2h 2D 5S 9C KD)
          hand_white = %w(3C 3H 4S 8C AH)

          expect(PokerHands.play(hand_black, hand_white)).to eq('White wins - with pair')

          hand_black = %w(5h 5D 6S 9C KD)
          hand_white = %w(3C 3H 4S 8C AH)

          expect(PokerHands.play(hand_black, hand_white)).to eq('Black wins - with pair')
        end

        it 'when the 2 playes have a pair with the same values, wins the player with the high card of the rest of the cards' do
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
          hand_black = %w(2H 3D 5S 9C KD)
          hand_white = %w(2C 3H 4S 8C AH)

          expect(PokerHands.play(hand_black, hand_white)).to eq('White wins - with high card: A')
        end

        context 'when both hands have the same highest card' do
          it 'wins the hand with the seconf highest card' do
            hand_black = %w(2H 3D 5S 9C AD)
            hand_white = %w(2C 3H 4S 8C AH)

            expect(PokerHands.play(hand_black, hand_white)).to eq('Black wins - with high card: 9')
          end
        end

        context 'when both hand have the same cards values' do
          it 'the result is tie' do
            hand_black = %w(2H 3D 5S 9C AD)
            hand_white = %w(2C 3H 5S 9C AH)

            expect(PokerHands.play(hand_black, hand_white)).to eq('Tie')
          end
        end
      end
    end
  end
end

