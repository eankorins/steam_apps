require 'json'

FactoryGirl.define do
  factory :player, :class => Player do |f|
  	initialize_with { Player.new(:account_id => 141032472) }
  end
end


def read_fixture(name)
	json = JSON.parse(File.read("#{Rails.root}/spec/fixtures/#{name}.json"))
end