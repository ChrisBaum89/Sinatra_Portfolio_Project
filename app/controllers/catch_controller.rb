class CatchController < ApplicationController
  get "/catch/new" do
    if Helpers.is_logged_in?(session)
      erb :"catch/new"
    else
      redirect '/login'
    end
  end

  get "/catch/:id" do
    if Helpers.is_logged_in?(session)
      @catch = Catch.find_by_id(params[:id])
      @catch_creator = User.find_by_id(@catch.user_id)
      erb :"catch/show"
    else
      redirect '/login'
    end
  end

end
