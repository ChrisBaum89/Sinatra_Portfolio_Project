class BaitController < ApplicationController

  get "/baits" do
    if Helpers.is_logged_in?(session)
      @user_bait = []
      @bait_catches = []
      @user = User.find(Helpers.current_user(session).id)
      Bait.all.each do |bait|
        if bait.user_id.to_i == @user.id
          @user_bait << bait
        end
      end
      erb :"baits/index"
    else
      redirect '/login'
    end
  end

  get "/baits/new" do
      erb :"baits/new"
  end

  get "/baits/:id" do
      @bait = Bait.find_by_id(params[:id])
      erb :"baits/show"
  end

  get "/baits/:id/edit" do
    @bait = Bait.find_by_id(params[:id])
    if @bait && (Helpers.current_user(session).id == @bait.user_id)
      erb :"baits/edit"
    elsif Helpers.is_logged_in?(session)
      redirect '/baits'
    else
      redirect '/login'
    end
  end

  post '/baits' do
    @user = User.find(Helpers.current_user(session).id)
    @bait = Helpers.new_bait(params, @user)
    redirect :"baits/#{@bait.id}"
  end

  patch '/baits/:id' do
    @bait = Bait.find_by_id(params[:bait_id])
    if Helpers.bait_valid(params)
      @bait.name = params[:bait_name]
      @bait.color= params[:bait_color]
      @bait.save
      redirect "/baits/#{@bait.id}"
    else
      redirect "/baits/#{@bait.id}/edit"
    end
  end
end
