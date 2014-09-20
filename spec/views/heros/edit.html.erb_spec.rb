require 'spec_helper'

describe "heros/edit" do
  before(:each) do
    @hero = assign(:hero, stub_model(Hero,
      :id => 1,
      :name => "MyString"
    ))
  end

  it "renders the edit hero form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", hero_path(@hero), "post" do
      assert_select "input#hero_id[name=?]", "hero[id]"
      assert_select "input#hero_name[name=?]", "hero[name]"
    end
  end
end
