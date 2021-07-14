class BaitController < ApplicationController

  get "/bait" do
    erb :"bait/index"
  end

  get "/bait/new" do
      erb :"bait/new"
  end

  get "/bait/:id" do
      @bait = Bait.find_by_id(params[:id])
      @bait_creator = User.find_by_id(@bait.user_id)
      erb :"bait/show"
  end
end
