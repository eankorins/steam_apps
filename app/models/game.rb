class Game < ActiveRecord::Base
	has_many :playedgames, :dependent => :destroy
	has_many :players, :through => :playedgames

	
end
