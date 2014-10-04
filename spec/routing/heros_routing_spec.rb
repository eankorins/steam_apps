require "spec_helper"

describe heroesController do
  describe "routing" do

    it "routes to #index" do
      get("/heroes").should route_to("heroes#index")
    end

    it "routes to #new" do
      get("/heroes/new").should route_to("heroes#new")
    end

    it "routes to #show" do
      get("/heroes/1").should route_to("heroes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/heroes/1/edit").should route_to("heroes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/heroes").should route_to("heroes#create")
    end

    it "routes to #update" do
      put("/heroes/1").should route_to("heroes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/heroes/1").should route_to("heroes#destroy", :id => "1")
    end

  end
end
