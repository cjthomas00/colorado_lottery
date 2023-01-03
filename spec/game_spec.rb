require './lib/contestant'
require './lib/game'

RSpec.describe Game do
  let(:alexander) do 
    Contestant.new({first_name: 'Alexander',
                                      last_name: 'Aigiades',
                                      age: 28,
                                      state_of_residence: 'CO',
                                      spending_money: 10})
  end
  let(:mega_millions) { Game.new('Mega Millions', 5, true) }
  let(:pick_4) { Game.new('Pick 4', 2) }

  describe '#initialize' do 
    it 'exists' do 
      expect(mega_millions).to be_instance_of(Game)
    end

    it 'has attributes' do
      expect(mega_millions.name).to eq('Mega Millions')
      expect(mega_millions.cost).to eq(5)
    end
  end
end
