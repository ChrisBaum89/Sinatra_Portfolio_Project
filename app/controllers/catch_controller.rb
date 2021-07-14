class CatchController < ApplicationController
  get "/catch" do
    erb :"catch/index"
  end

  get "/catch/new" do
      erb :"catch/new"
  end

  get "/catch/:id" do
      @catch = Catch.find_by_id(params[:id])
      @catch_creator = User.find_by_id(@catch.user_id)
      erb :"catch/show"
  end

end
