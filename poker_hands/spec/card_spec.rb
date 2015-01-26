require_relative '../card'

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

