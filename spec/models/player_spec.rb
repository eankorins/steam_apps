require 'spec_helper'

describe "playerModel" do
	subject(:player) { FactoryGirl.build(:player) }
	describe 'adding' do
		
		describe "is created" do
			its(:account_id) { should eq 141032472 }
			its(:name) { should eq "Abstract" }

		end
	end
end