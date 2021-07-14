class BaitController < ApplicationController

  get "/baits" do
    erb :"baits/index"
  end

  get "/baits/new" do
      erb :"baits/new"
  end

  get "/baits/:id" do
      @bait = Bait.find_by_id(params[:id])
      @bait_creator = User.find_by_id(@bait.user_id)
      erb :"baits/show"
  end

  post '/baits' do
    binding.pry
  end
end
