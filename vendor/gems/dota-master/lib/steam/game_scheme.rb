require 'steam/utils/inspectable'

module Steam
	class GameScheme
		include Utils::Inspectable
		attr_reader :raw_scheme

		def initialize(raw_scheme)
			@raw_scheme = raw_scheme
		end

		def stats
			if s = raw_scheme['stats']
				s.map { |m| Stat.new(m)}
			end
		end

		def achievements
			if a = raw_scheme['achievements']
				a.map { |m| Achievement.new(m)}
			end
		end
	end
	class Stat
		include Utils::Inspectable
		attr_reader :raw_stat

		def initialize(raw_stat)
			@raw_stat = raw_stat
		end

		def name
			raw_stat['name']
		end
		def value 
			raw_stat['defaultvalue']
		end
		def display_name
			raw_stat['displayName']
		end
	end
	class Achievement
		include Utils::Inspectable
		attr_reader :raw_achievment

		def initialize(raw_achievment)
			@raw_achievment = raw_achievment
		end

		def name 
			raw_achievment['name']
		end

		def value 
			raw_achievment['defaultvalue']
		end

		def display_name
			raw_achievment['displayName']
		end

		def hidden 
			raw_achievment['hidden']
		end

		def description
			raw_achievment['description']
		end

		def icon
			raw_achievment['icon']
		end

		def icongray
			raw_achievment['icongray']
		end
	end
end