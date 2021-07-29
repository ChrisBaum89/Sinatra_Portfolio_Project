class CatchController < ApplicationController
  get "/catches" do
    if Helpers.is_logged_in?(session)
      @user_catches = []
      @user = User.find(Helpers.current_user(session).id)
      erb :"catches/index"
    else
      redirect '/login'
    end
  end

  get "/catches/new" do
    if Helpers.is_logged_in?(session)
      @user_bait = []
      @user = User.find(Helpers.current_user(session).id)
      Bait.all.each do |bait|
        if bait.user_id.to_i == @user.id
          @user_bait << bait
        end
      end
      erb :"catches/new"
    else
      redirect '/login'
    end
  end

  get "/catches/:id" do
    if Helpers.is_logged_in?(session)
      @user = User.find(Helpers.current_user(session).id)
      @catch = Catch.find_by_id(params[:id])
      @bait = Bait.find_by_id(@catch.bait_id)
      erb :"catches/show"
    else
      redirect '/login'
    end
  end

  get "/catches/:id/edit" do
    if Helpers.is_logged_in?(session)
      @catch = Catch.find_by_id(params[:id])
      @bait = Bait.find_by_id(@catch.bait_id)
      @user = User.find(Helpers.current_user(session).id)
      @user_bait = []

      #verifies if the user is the owner of the catch
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

      redirect "/catches/#{@catch.id}"
    else
      redirect '/catches/new'
    end
    redirect "/catches/#{@catch.id}"
  end

  patch '/catches/:id' do
    @user = User.find(Helpers.current_user(session).id)
    @catch = Catch.find_by_id(params[:catch_id])
    if Helpers.fish_valid(params) && Helpers.bait_valid(params)

      #set to fish information to new values
      Helpers.catch_fish_info(params)

      #verify if a checked bait is selected or if a new bait must be created
      if params[:bait_id_checked] != nil
        @bait = Bait.find_by_id(params[:bait_id_checked])
      else
        @bait = Helpers.new_bait(params,@user)
      end
      @catch.bait_id = @bait.id

      #save catch and fish
      @catch.fish.save
      @catch.save
      redirect "/catches/#{@catch.id}"
    else
      redirect "/catches/#{@catch.id}/edit"
    end
  end

  get '/catches/:id/delete' do
    if Helpers.is_logged_in?(session)
      @catch = Catch.find_by_id(params[:id])
      @catch.delete
      redirect "/catches"
    else
      redirect '/login'
    end
  end

end
