class CatchController < ApplicationController
  get "/catches" do
    @user_catches = []
    @user = User.find(Helpers.current_user(session).id)
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
      @bait = Bait.find_by_id(@catch.bait_id)
      erb :"catches/show"
  end

  get "/catches/:id/edit" do
    @catch = Catch.find_by_id(params[:id])
    @bait = Bait.find_by_id(@catch.bait_id)
    @user = User.find(Helpers.current_user(session).id)
    @user_bait = []
    if @catch && (Helpers.current_user(session).id == @bait.user_id)
      Bait.all.each do |bait|
        if bait.user_id.to_i == @user.id
          @user_bait << bait
        end
      end
      erb :"catches/edit"
    elsif Helpers.is_logged_in?(session)
      redirect '/catches'
    else
      redirect '/login'
    end
  end

  post '/catches' do
    #create catch
    @catch = Catch.new()

    if @catch.save
      @catch.created_at = Time.now + Time.zone_offset('EST')

      #determine if bait is selected or create new bait object if new
      @bait = params["bait_id_checked"]
      if @bait == "" || @bait == nil
        @bait = Bait.new(name: params["bait_name"], color: params["bait_color"], user_id: session[:user_id])
        @bait.save
        @catch.bait_id = @bait.id
      else
        @catch.bait_id = @bait.to_i
      end
      @catch.save

      #create fish
      @fish = Fish.new(species: params["fish_species"], weight: params["fish_weight"], length: params["fish_length"], catch_id: @catch.id)
      @fish.save

      redirect '/catches'
    else
      redirect '/catches/new'
    end
    redirect :"baits/#{@bait.id}"
  end

end
