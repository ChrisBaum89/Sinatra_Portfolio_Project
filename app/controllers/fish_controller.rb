class FishController < ApplicationController
  get "/fish" do
    erb :"fish/index"
  end

  get "/fish/new" do
      erb :"fish/new"
  end
end
