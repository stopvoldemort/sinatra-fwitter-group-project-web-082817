require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  enable :sessions

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :'users/new'
  end


  get '/login' do
    erb :'users/login'
  end

  get '/logout' do
    session.find(@user.id).clear
    erb :'users/logout'
  end

  post '/login' do
    # Receive post from login
    # Start sessions with users id
    @user = User.find_by(username: params[:username])
    session[:id] = @user.id
    binding.pry
    redirect to '/'
  end


  get '/tweets' do
    @tweets = Tweet.all
    erb :'tweets/index'
  end

  get '/tweets/new' do
    # Need to send the user id of the person writing the new tweet.
    erb :'tweets/new'
  end

  post '/tweets' do
    Tweet.create(params)
    redirect to '/tweets'
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    erb :'tweets/show'
  end

  get '/tweets/:id/edit' do
    # Grab instance of tweet
    erb :'tweets/edit'
  end

  patch '/tweets/:id' do
    # Receive patch from '/tweets/:id/edit'
    redirect to "/tweets/#{@tweet.id}"
  end

  delete '/tweets/:id' do
    Tweet.find(params[:id]).destroy
    redirect to '/tweets'
  end



end
