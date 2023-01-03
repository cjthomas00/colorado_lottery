require './lib/contestant'

RSpec.describe Contestant do
  let(:alexander) do 
    Contestant.new({first_name: 'Alexander',
                                      last_name: 'Aigiades',
                                      age: 28,
                                      state_of_residence: 'CO',
                                      spending_money: 10})
  end
  
  describe '#initialize' do
    it "exists" do 
      expect(alexander).to be_instance_of(Contestant)
    end
  end
end
