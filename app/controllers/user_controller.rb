class UserController < ApplicationController

  get "/signup" do
      if Helpers.is_logged_in?(session)
        redirect '/catches'
      else
        erb :"users/signup"
      end
    end

    post "/signup" do
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      if @user.save
        session[:user_id] = @user.id
        redirect '/catches'
      else
        redirect '/signup'
      end
    end

    get "/login" do
      if Helpers.is_logged_in?(session)
        redirect '/catches'
      else
        erb :"users/login"
      end
    end

    post '/login' do
      binding.pry
      user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect '/catches'
      else
        redirect '/login'
      end
    end

    get "/logout" do
      session.clear
      redirect '/login'
    end
end
