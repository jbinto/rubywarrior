class Player

  attr_accessor :warrior

  def initialize
  	@old_health = 20
  end

  def play_turn(warrior)
  	# make it easier to call methods...
  	self.warrior = warrior 

  	log "health: #{warrior.health}"

  	if empty_ahead?
  		log "It's empty in front of us."
  		if should_rest?
  			log "I think I'll rest for now."
  			warrior.rest!
  		else
  			log "I'll walk forward."
			warrior.walk!
		end
	else # it's not empty in front of us...
		log "Attack!"
		warrior.attack!
	end

	@old_health = warrior.health
  end

  def log(message)
  	puts "--> #{message}"
  end

  def empty_ahead?  	
  	warrior.feel.empty?
  end

  def hurt?
  	warrior.health < 20
  end

  def should_rest?
  	log "Should I rest?"
  	if just_took_damage?
  		log "I just took damage, so I can't rest!"
  		false
  	else
  		log "Am I hurt? #{hurt?}. Is it empty ahead? #{empty_ahead?}"
  		hurt? && empty_ahead?
  	end
  end

  def just_took_damage?
  	warrior.health < @old_health
  end

end
