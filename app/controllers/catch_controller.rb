class CatchController < ApplicationController
  get "/catch" do
    erb :"catch/index"
  end

end
