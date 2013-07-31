require "spec_helper"

describe ClocksController do
  describe "routing" do

    it "routes to #index" do
      get("/clocks").should route_to("clocks#index")
    end

    it "routes to #new" do
      get("/clocks/new").should route_to("clocks#new")
    end

    it "routes to #show" do
      get("/clocks/1").should route_to("clocks#show", :id => "1")
    end

    it "routes to #edit" do
      get("/clocks/1/edit").should route_to("clocks#edit", :id => "1")
    end

    it "routes to #create" do
      post("/clocks").should route_to("clocks#create")
    end

    it "routes to #update" do
      put("/clocks/1").should route_to("clocks#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/clocks/1").should route_to("clocks#destroy", :id => "1")
    end

  end
end
