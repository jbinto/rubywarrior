class Player

  attr_accessor :warrior

  def initialize
  	@old_health = 20
  	@direction = :forward
  end

  def play_turn(warrior)
  	# make it easier to call methods...
  	self.warrior = warrior 

  	log "health: #{warrior.health}"

    log "look: #{warrior.look[0].to_s}"
  	if must_shoot_wizard?
      log "Wizard (but no captive) ahead -- shoot!"
      warrior.shoot!
    elsif empty?
  		log "It's empty in the #{@direction.to_s} direction."
  		if just_got_shot? && not_enough_health_to_attack?
        log "I just got shot, and I don't have enough health to attack. Going backwards."
  			change_direction_to(:backward)
        walk!
  		elsif should_rest?
  			log "I think I'll rest for now."
  			warrior.rest!
  		else
  			log "I'll walk #{@direction.to_s}."
			 walk!
		  end
  	elsif wall?
  		#hange_direction!
      warrior.pivot!
  	elsif captive? # it's not empty in front of us...
  		log "Freeing the captive..."
  		rescue!
  	else
  		log "Attack!"
  		attack!
  	end

	@old_health = warrior.health
  end

  def log(message)
  	puts "--> #{message}"
  end

  def empty?  	
  	warrior.feel(@direction).empty?
  end

  def captive?
  	warrior.feel(@direction).captive?
  end

  def hurt?
  	warrior.health < 20
  end

  def walk!
  	warrior.walk!(@direction)
  end

  def rescue!
  	warrior.rescue!(@direction)
  end

  def attack!
  	warrior.attack!(@direction)
  end

  def wall?
  	warrior.feel(@direction).wall?
  end

  def change_direction!
  	if @direction == :forward
  		@direction = :backward
  	else
  		@direction = :forward
  	end

  	warrior.walk!(@direction)
  end

  def should_rest?
  	log "Should I rest?"
  	if just_took_damage?
  		log "I just took damage, so I can't rest!"
  		false
  	else
  		log "Am I hurt? #{hurt?}. Is it empty in the #{@direction.to_s}? #{empty?}"
  		hurt? && empty?
  	end
  end

  def just_took_damage?
  	warrior.health < @old_health
  end

  def just_got_shot?
  	just_took_damage? && empty?
  end

  def not_enough_health_to_attack?
    warrior.health < 15
  end

  def change_direction_to(direction)
    @direction = direction
  end

  def must_shoot_wizard?
    strings_ahead = warrior.look.map {|thing| thing.to_s }
    
    should_shoot = false 

    log "ahead: #{strings_ahead}"

    for tile in strings_ahead
      if tile == "Wizard"
        should_shoot = true   
        break
      elsif tile == "nothing"
        next
      else
        break   # don't shoot anything
      end
    end

    #return strings_ahead.include?("Wizard") && !strings_ahead.include?("Captive")

    should_shoot
  end

end
