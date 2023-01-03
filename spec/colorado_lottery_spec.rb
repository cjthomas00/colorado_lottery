require "./lib/contestant"
require "./lib/game"
require "./lib/colorado_lottery"

RSpec.describe ColoradoLottery do
  let(:lottery) { ColoradoLottery.new }
  let(:pick_4) { Game.new('Pick 4', 2) }
  let(:cash_5) { Game.new('Cash 5', 1) }
  let(:mega_millions) { Game.new('Mega Millions', 5, true) }
  let(:alexander) do 
    Contestant.new({
                       first_name: 'Alexander',
                       last_name: 'Aigades',
                       age: 28,
                       state_of_residence: 'CO',
                       spending_money: 10
                      })
  end
  let(:benjamin) do
    Contestant.new({
                       first_name: 'Benjamin',
                       last_name: 'Franklin',
                       age: 17,
                       state_of_residence: 'PA',
                       spending_money: 100
                      })
  end
  let(:frederick) do
    Contestant.new({
                       first_name:  'Frederick',
                       last_name: 'Douglass',
                       age: 55,
                       state_of_residence: 'NY',
                       spending_money: 20
                      })
  end
  let(:winston) do
    Contestant.new({
                     first_name: 'Winston',
                     last_name: 'Churchill',
                     age: 18,
                     state_of_residence: 'CO',
                     spending_money: 5
                    })
  end

  before do 
    alexander.add_game_interest('Pick 4')
    alexander.add_game_interest('Mega Millions')
    frederick.add_game_interest('Mega Millions')
    winston.add_game_interest('Cash 5')
    winston.add_game_interest('Mega Millions')
    benjamin.add_game_interest('Mega Millions')
  end
  describe '#initialize' do
    it 'exists' do
    expect(lottery).to be_instance_of(ColoradoLottery)
    end
  end 
end