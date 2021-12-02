require './config/environment'
require 'securerandom'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    #session_secret is set by value in config/session_secret.md file.
    #value in that file was randomly generated with SecureRandom.hex(64)
    #session_secret.md file is ignored by .gitignore to protect session_secret
    set :session_secret, File.read('config/session_secret.md')
  end

  get "/" do
    erb :index
  end
end
