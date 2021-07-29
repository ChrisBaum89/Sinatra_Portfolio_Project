class CatchController < ApplicationController
  get "/catches" do
    if Helpers.is_logged_in?(session)
      @user_catches = []
      @user = Helpers.current_user(session)
      erb :"catches/index"
    else
      redirect '/login'
    end
  end

  get "/catches/new" do
    if Helpers.is_logged_in?(session)
      @user_bait = []
      @user = Helpers.current_user(session)
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
      @user = Helpers.current_user(session)
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
      @user = Helpers.current_user(session)
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
      Helpers.new_fish(@catch, session, params)

      redirect "/catches/#{@catch.id}"
    else
      redirect '/catches/new'
    end
    redirect "/catches/#{@catch.id}"
  end

  patch '/catches/:id' do
    @user = Helpers.current_user(session)
    @catch = Catch.find_by_id(params[:catch_id])
    if Helpers.fish_valid(params) && Helpers.bait_valid(params)

      #set to fish information to new values
      Helpers.catch_fish_info(@catch, params)

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
