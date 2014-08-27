class Participant < ActiveRecord::Base
	belongs_to :match
	belongs_to :player, :class_name => "Player", :foreign_key => "steamid"
end
