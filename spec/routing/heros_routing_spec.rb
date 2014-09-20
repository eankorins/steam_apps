require "spec_helper"

describe HerosController do
  describe "routing" do

    it "routes to #index" do
      get("/heros").should route_to("heros#index")
    end

    it "routes to #new" do
      get("/heros/new").should route_to("heros#new")
    end

    it "routes to #show" do
      get("/heros/1").should route_to("heros#show", :id => "1")
    end

    it "routes to #edit" do
      get("/heros/1/edit").should route_to("heros#edit", :id => "1")
    end

    it "routes to #create" do
      post("/heros").should route_to("heros#create")
    end

    it "routes to #update" do
      put("/heros/1").should route_to("heros#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/heros/1").should route_to("heros#destroy", :id => "1")
    end

  end
end
