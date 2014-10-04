require 'spec_helper'

describe "heroes/new" do
  before(:each) do
    assign(:hero, stub_model(Hero,
      :id => 1,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new hero form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", heroes_path, "post" do
      assert_select "input#hero_id[name=?]", "hero[id]"
      assert_select "input#hero_name[name=?]", "hero[name]"
    end
  end
end
