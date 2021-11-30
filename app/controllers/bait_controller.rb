class BaitController < ApplicationController

  get "/baits" do
    #if user is logged in, find all bait owned by the user and set to @user_bait
    if Helpers.is_logged_in?(session)
      @user_bait = []
      @user = Helpers.current_user(session)
      Bait.all.each do |bait|
        if bait.user_id.to_i == @user.id
          @user_bait << bait
        end
      end
      erb :"baits/index"
    #if user is not logged in, redirect to login
    else
      redirect '/login'
    end
  end

  get "/baits/new" do
    #only allow user to route to baits/new if they are logged in
    if Helpers.is_logged_in?(session)
      erb :"baits/new"
    else
      redirect '/login'
    end
  end

  get "/baits/:id" do
    #if user is logged in and bait is found, render baits/show, else redirect to /baits
    if Helpers.is_logged_in?(session)
      @bait = Bait.find_by_id(params[:id])
      if @bait
        if (@bait.user_id != Helpers.current_user(session).id)
          redirect '/baits'
        end
        erb :"baits/show"
      else
        redirect '/baits'
      end
    #if user not logged in, redirect to login
    else
      redirect '/login'
    end
  end

  get "/baits/:id/edit" do
    #allow route to baits/edit if user logged in, bait is found, and belongs to current user
    if Helpers.is_logged_in?(session)
      @bait = Bait.find_by_id(params[:id])
      if @bait && (Helpers.current_user(session).id == @bait.user_id)
        erb :"baits/edit"
      elsif Helpers.is_logged_in?(session)
        redirect '/baits'
      else
        redirect '/login'
      end

    else
      redirect '/login'
    end
  end

  post '/baits' do
    #verify that bait is valid before creating new bait
    if Helpers.bait_valid(params)
      @user = Helpers.current_user(session)
      @bait = Helpers.new_bait(params, @user)
      redirect "/baits/#{@bait.id}"
    #if bait not valid, redirect to baits/new
    else
      redirect "/baits/new"
    end
  end

  patch '/baits/:id' do
    #find bait to edit
    @bait = Bait.find_by_id(params[:bait_id])
    #if bait params valid, assign new values and save
    if Helpers.bait_valid(params)
      @bait.name = params[:bait_name]
      @bait.color= params[:bait_color]
      @bait.save
      redirect "/baits/#{@bait.id}"
    #if bait not valid, redirect to edit page
    else
      redirect "/baits/#{@bait.id}/edit"
    end
  end

  get '/baits/:id/delete' do
    if Helpers.is_logged_in?(session)
      @bait = Bait.find_by_id(params[:id])
      #find all catches and fish associated with the bait and delete
      Catch.all.each do |catch|
        if catch.bait_id == @bait.id
          if catch.fish != nil
            catch.fish.delete
          end
          catch.delete
        end
      @bait.delete
      end
      redirect "/baits"
    else
      redirect '/login'
    end
  end
end
