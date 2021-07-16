class FishController < ApplicationController
  get "/fish" do
    @user_fish = []
    @user = User.find(Helpers.current_user(session).id)
    Fish.all.each do |fish|
      if fish.user_id.to_i == @user.id
        @user_fish << fish
      end
    end
    erb :"fish/index"
  end

  get "/fish/:id" do
      @fish = Fish.find_by_id(params[:id])
      @fish_creator = User.find_by_id(@fish.user_id)
      erb :"fish/show"
  end

end
