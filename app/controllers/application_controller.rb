require './config/environment'

class ApplicationController < Sinatra::Base

  include ApplicationHelpers

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
    if !logged_in?
      erb :'users/new'
    else
      redirect to '/tweets'
    end
  end


  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect to '/tweets'
    end
  end

  get '/logout' do
    redirect to '/login'
  end

  post '/logout' do
    session.clear
    redirect to '/login'
  end

  post '/login' do
    # Receive post from login
    # Start sessions with users id
    @user = User.find_by(username: params[:username])
    session[:id] = @user.id
    redirect to '/tweets'
  end

  post '/signup' do
    # @username = params[:username]
    if params.values.include?("")
      redirect to '/signup'
    else
      @user = User.create(params)
      session[:id] = @user.id
      redirect to '/tweets'
    end
  end

  get '/tweets' do
    if session[:id]
      @tweets = Tweet.all
      erb :'tweets/index'
    else
      redirect to '/login'
    end
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

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    @user_tweets = User.find_by_slug(params[:slug]).tweets
    erb :'users/show'
  end

  post '/tweets' do
    Tweet.create(params)
    redirect to '/tweets'
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if !session[:id]
      redirect to '/login'
    else
      @user = User.find(session[:id])
      if @tweet.user != @user
        erb :'tweets/show'
      else
        erb :'tweets/edit'
      end
    end
  end

  patch '/tweets/:id' do
    # Receive patch from '/tweets/:id/edit'
    @tweet = Tweet.find(params[:id])
    redirect to "/tweets/#{@tweet.id}"
  end

  delete '/tweets/:id' do
    Tweet.find(params[:id]).destroy
    redirect to '/tweets'
  end



end
