class CatchController < ApplicationController
  get "/catch" do
    erb :"catch/index"
  end

  get "/catch/new" do
      erb :"catch/new"
  end

end
