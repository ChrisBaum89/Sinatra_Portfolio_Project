class FishController < ApplicationController
  get "/fish" do
    erb :"fish/index"
  end
end
