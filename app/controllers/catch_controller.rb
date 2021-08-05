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
    @user = Helpers.current_user(session)
    @catch = Catch.new()

    #create fish object
    if Helpers.fish_valid(params)
      @fish = Fish.new(species: params["fish_species"], weight: params["fish_weight"], length: params["fish_length"], catch_id: nil)
    else
      redirect '/catches/new'
    end

    #verify if existing bait is selected and assign it or create a new bait object
    if Helpers.existing_bait_valid(params)
      @catch.bait_id = params[:bait_id_checked]
    elsif Helpers.new_bait_valid(params)
      @bait = Bait.new(name: params[:bait_name], color: params[:bait_color], user_id: @user.id)
    else
      redirect '/catches/new'
    end

    #all info valid, then save catch, save fish, and if applicable, save bait
    if Helpers.fish_valid(params) && (Helpers.existing_bait_valid(params) || Helpers.new_bait_valid(params))
      @catch.created_at = Time.now + Time.zone_offset('EST')
      @catch.save #create catch
      @fish.catch_id = @catch.id
      @fish.save
      if Helpers.new_bait_valid(params)
        @bait.save
        @catch.bait_id = @bait.id
        @catch.save
      elsif Helpers.existing_bait_valid(params)
        @catch.bait_id = params[:bait_id_checked]
        @catch.save
      end
      redirect '/catches'
    else
      redirect '/catches/new'
    end

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
      if @catch.fish != nil
        @catch.fish.delete
      end
      @catch.delete
      redirect "/catches"
    else
      redirect '/login'
    end
  end

end
