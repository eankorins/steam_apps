module Steam
	class Hero
		attr_reader :raw_hero

		def initialize(raw_hero)
			@raw_hero = raw_hero
		end

		def id
			@raw_hero['id']
		end

		def name
			@raw_hero['name'].split('_')[3..-1].join(' ').capitalize
		end
	end
end