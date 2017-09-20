require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_secret"
  end


  get '/' do
    erb :index
  end

  get '/signup' do
    erb :'users/new'
  end


  get '/login' do
    erb :'users/login'
  end

  post '/logout' do
    session.clear
    erb :'users/login'
  end

  post '/login' do
    # Receive post from login
    # Start sessions with users id
    @user = User.find_by(username: params[:username])
    session[:id] = @user.id
    redirect to '/tweets'
  end

  post '/signup' do
    @user = User.create(params)
    session[:id] = @user.id
    redirect to '/'
  end

  get '/tweets' do
    @tweets = Tweet.all
    erb :'tweets/index'
  end

  get '/tweets/new' do
    if !session[:id]
      redirect to '/login'
    else
      @user = User.find(session[:id])
      @tweets = Tweet.all
      erb :'tweets/new'
    end
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
    if !session[:id]
      redirect to '/login'
    else
      @user = User.find(session[:id])
      if Tweet.find(params[:id]).user != @user
        redirect to "/tweets/#{params[:id]}"
      else
        erb :'tweets/edit'
      end
    end
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
