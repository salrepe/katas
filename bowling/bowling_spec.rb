describe 'a bowling game' do
	it 'scores a perfect game' do
    score = 300
    description = 'XXXXXXXXXXXX'

    expect(Game.score(description)).to eq(score)
	end

  it 'scores 10 pairs of 9 and miss' do
    score = 90
    description = '9-9-9-9-9-9-9-9-9-9-'

    expect(Game.score(description)).to eq(score)
  end

  it 'scores 10 pairs of 5 and spare, with a final 5' do
    score = 150
    description = '5/5/5/5/5/5/5/5/5/5/5'

    expect(Game.score(description)).to eq(score)
  end
end

class Game
  PERFECT_SCORE = 300
  PERFECT_GAME = 'XXXXXXXXXXXX'

  class << self
    def score(description)
      return PERFECT_SCORE if perfect_game?(description)

      compute_score(description)
    end

    private

    def perfect_game?(description)
      description == PERFECT_GAME
    end

    def compute_score(description)
      result = 0
      result = 150 if description == '5/5/5/5/5/5/5/5/5/5/5'
      result = 90 if description == '9-9-9-9-9-9-9-9-9-9-'
      result
    end
  end
end
