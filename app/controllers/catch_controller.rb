class CatchController < ApplicationController
  get "/catches" do
    @user_catches = []
    @user = User.find(Helpers.current_user(session).id)
    Catch.all.each do |catch|
      if catch.user_id.to_i == @user.id
        @user_catches << catch
      end
    end
    erb :"catches/index"
  end

  get "/catches/new" do
    @user_bait = []
    @user = User.find(Helpers.current_user(session).id)
    Bait.all.each do |bait|
      if bait.user_id.to_i == @user.id
        @user_bait << bait
      end
    end
      erb :"catches/new"
  end

  get "/catches/:id" do
      @catch = Catch.find_by_id(params[:id])
      @catch_creator = User.find_by_id(@catch.user_id)
      erb :"catches/show"
  end

  post '/catches' do
    @catch = Catch.new()
    @bait = params["bait_id_checked"]
    if @bait == ""
      @bait = Bait.new(name: params["bait_name"], color: params["bait_color"])
    else
      @catch.bait_id = @bait.to_i
    end
    binding.pry
    @fish = Fish.new(species: params["fish_species"], weight: params["fish_weight"], length: params["fish_length"])
    redirect :"baits/#{@bait.id}"
  end

end
