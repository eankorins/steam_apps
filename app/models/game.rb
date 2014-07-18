class Game < ActiveRecord::Base
	has_many :playedgames, :dependent => :destroy
	has_many :players, :through => :playedgames
	has_many :achievements, :dependent => :destroy
	after_create :get_scheme

	
end
