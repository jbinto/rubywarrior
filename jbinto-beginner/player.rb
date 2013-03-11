class Player
  def play_turn(warrior)
  	if warrior.feel.empty?
  		log "It's empty in front of us."
  		if warrior.health < 20
  			puts "I'm hurt, I'll rest for now."
  			warrior.rest!
  		else
  			puts "I'm healthy. I'll walk forward."
			warrior.walk!
		end
	else # it's not empty in front of us...
		log "Attack!"
		warrior.attack!
	end
  end

  def log(message)
  	puts "--> #{message}"
  end
end
