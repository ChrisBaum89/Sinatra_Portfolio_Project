class BaitController < ApplicationController

  get "/baits" do
    @baits = Bait.all
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
    session[:user_id] = 1
    @bait = Bait.new(name: params["bait_name"], color: params["bait_color"], user_id: session[:user_id])
    @bait.save
    redirect :"baits/#{@bait.id}"
  end
end
