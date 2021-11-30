class UserController < ApplicationController

  get "/signup" do
      #requires there to be no current user logged in to route to users/signup
      if Helpers.is_logged_in?(session)
        redirect '/catches'
      else
        erb :"users/signup"
      end
    end

    #create new User object and redirect to catches
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
      #requires there to be no current user logged in to route to users/login
      if Helpers.is_logged_in?(session)
        redirect '/catches'
      else
        erb :"users/login"
      end
    end

    post '/login' do
      #find user by usersname that was entered
      user = User.find_by(username: params[:username])
      #authenticate password
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect '/catches'
      else
        redirect '/login'
      end
    end

    #loging out clears session and redirects to login
    get "/logout" do
      session.clear
      redirect '/login'
    end
end
