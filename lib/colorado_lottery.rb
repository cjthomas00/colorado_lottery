class ColoradoLottery
  attr_reader :registered_contestants,
              :winners,
              :current_contestants

  def initialize
    # @registered_contestants = {}
    @registered_contestants = Hash.new { |k, v| k[v] = [] }
    @winners = []
    @current_contestants = {}
  end

  def interested_and_18?(contestant, game)
     contestant.age >= 18 && contestant.game_interests.include?(game.name)
  end

  def can_register?(contestant, game)
  interested_and_18?(contestant, game) && 
    (!contestant.out_of_state? || game.national_drawing?) 
  end

  def register_contestant(contestant, game)
    if can_register?(contestant, game) 
      # if @registered_contestants[game.name].nil?
      #   @registered_contestants[game.name] = []
      # end
      #   @registered_contestants[game.name] << contestant
        @registered_contestants[game.name] << contestant
    end 
  end
end