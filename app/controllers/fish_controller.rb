class FishController < ApplicationController
  get "/fish" do
    erb :"fish/index"
  end

  get "/fish/:id" do
      @fish = Fish.find_by_id(params[:id])
      @fish_creator = User.find_by_id(@fish.user_id)
      erb :"fish/show"
  end

end
