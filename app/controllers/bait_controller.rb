class BaitController < ApplicationController

  get "/baits" do
    @user_bait = []
    @user = User.find(Helpers.current_user(session).id)
    Bait.all.each do |bait|
      if bait.user_id.to_i == @user.id
        @user_bait << bait
      end
    end
    erb :"baits/index"
  end

  get "/baits/new" do
      erb :"baits/new"
  end

  get "/baits/:id" do
      @bait = Bait.find_by_id(params[:id])
      erb :"baits/show"
  end

  post '/baits' do
    @bait = Bait.new(name: params["bait_name"], color: params["bait_color"], user_id: session[:user_id])
    @bait.save
    redirect :"baits/#{@bait.id}"
  end
end
