class Contestant
  attr_reader :full_name, :age, :state_of_residence, :spending_money

  def initialize(info)
    @full_name = "#{info[:first_name]} #{info[:last_name]}"
    @age = info[:age]
    @state_of_residence = info[:state_of_residence]
    @spending_money = info[:spending_money]
  end
end