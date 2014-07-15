class Player < ActiveRecord::Base
	has_many :playedgames, :dependent => :destroy
	has_many :games, :through => :playedgames
end
