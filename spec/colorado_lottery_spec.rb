require "./lib/contestant"
require "./lib/game"
require "./lib/colorado_lottery"

RSpec.describe ColoradoLottery do
  let(:lottery) { ColoradoLottery.new }
  let(:pick_4) { Game.new('Pick 4', 2) }
  let(:cash_5) { Game.new('Cash 5', 1) }
  let(:mega_millions) { Game.new('Mega Millions', 5, true) }
  let(:grace) do
    Contestant.new({
                     first_name: 'Grace',
                     last_name: 'Hopper',
                     age: 20,
                     state_of_residence: 'CO',
                     spending_money: 20})
  end
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
    grace.add_game_interest('Mega Millions')
    grace.add_game_interest('Cash 5')
    grace.add_game_interest('Pick 4')
  end
  describe '#initialize' do
    it 'exists' do
    expect(lottery).to be_instance_of(ColoradoLottery)
    end

    it 'has attributes' do
      expect(lottery.registered_contestants).to eq({})
      expect(lottery.winners).to eq([])
      expect(lottery.current_contestants).to eq({})
    end
  end

  describe '#interested_and_18?' do
    it 'returns true' do
      expect(lottery.interested_and_18?(alexander, pick_4)).to eq(true)
      expect(lottery.interested_and_18?(benjamin, mega_millions)).to eq(false)
      expect(lottery.interested_and_18?(alexander, cash_5)).to eq(false)
    end
  end

  describe '#can_register?' do
    it 'returns true when interested_and_18, colorado resident or game is national' do 
      expect(lottery.can_register?(alexander, pick_4)).to eq(true)
      expect(lottery.can_register?(alexander, cash_5)).to eq(false)
      expect(lottery.can_register?(frederick, mega_millions)).to eq(true)
      expect(lottery.can_register?(benjamin, mega_millions)).to eq(false)
      expect(lottery.can_register?(frederick, cash_5)).to eq(false)
    end

    describe '#register_contestant' do
      it 'can register a contestant' do
        lottery.register_contestant(alexander, pick_4)

        expect(lottery.registered_contestants).to eq({ 'Pick 4' => [alexander] })

        lottery.register_contestant(alexander, mega_millions)

        expect(lottery.registered_contestants).to eq({ 'Pick 4' => [alexander], 'Mega Millions' => [alexander] })
        lottery.register_contestant(frederick, mega_millions)
        lottery.register_contestant(winston, cash_5)
        lottery.register_contestant(winston, mega_millions)

        expected_hash = {
          'Pick 4' => [alexander],
          'Mega Millions' => [alexander, frederick, winston],
          'Cash 5' => [winston]
        }

        expect(lottery.registered_contestants).to eq(expected_hash)

        lottery.register_contestant(grace, mega_millions)
        lottery.register_contestant(grace, cash_5)
        lottery.register_contestant(grace, pick_4)

        expected_hash = {
        'Pick 4' => [alexander, grace],
        'Mega Millions' => [alexander, frederick, winston, grace],
        'Cash 5' => [winston, grace]
        }

        expect(lottery.registered_contestants).to eq(expected_hash)
      end
    end
  end

  describe '#eligible_contestants' do
      before do 
        lottery.register_contestant(alexander, pick_4)
        lottery.register_contestant(alexander, mega_millions)
        lottery.register_contestant(frederick, mega_millions)
        lottery.register_contestant(winston, cash_5)
        lottery.register_contestant(winston, mega_millions)
        lottery.register_contestant(grace, mega_millions)
        lottery.register_contestant(grace, cash_5)
        lottery.register_contestant(grace, pick_4)
      end

      it 'returns array of eligible contestants who have been registered and can pay for their tickets.' do 
        expect(lottery.eligible_contestants(pick_4)).to eq([alexander, grace])
        expect(lottery.eligible_contestants(cash_5)).to eq([winston, grace])
        expect(lottery.eligible_contestants(mega_millions)).to eq([alexander, frederick, winston, grace])
      end
    end
end