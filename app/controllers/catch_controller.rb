class CatchController < ApplicationController
  get "/catches" do
    erb :"catches/index"
  end

  get "/catches/new" do
      @baits = Bait.all
      erb :"catches/new"
  end

  get "/catches/:id" do
      @catch = Catch.find_by_id(params[:id])
      @catch_creator = User.find_by_id(@catch.user_id)
      erb :"catches/show"
  end

end
