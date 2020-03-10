class UsersController < ApplicationController

  get "/users" do
    erb :"/users/index.html"
  end
  
  get "/users/create_account" do
    if logged_in?
       redirect "/users/#{current_user.id}"
    end
    erb :"/users/create_account.html"
  end

  post "/users" do
    if !User.all.find_by(username: params[:username]) && !params.empty?
      user = User.create(params)
      session[:user_id] = user.id
      redirect "/users/#{user.id}"
    else
      redirect "/users/create_account"
    end
  end

  post '/login' do
    if @user = User.find_by(username: params[:username])
      @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    else
      redirect "/users/create_account"
    end
  end
  
  get '/users/collection' do 
    if !logged_in?
      redirect "/login"
    end
    flash.now[:warning] = "Uhhhhhh"
    erb :"/users/collection.html"
  end

  get '/logout' do 
    if logged_in? && (session[:user_id] > 0)
      session.clear 
      redirect "/"
    end
  end

  get "/users/:id" do
    @user = User.find(params[:id])
    erb :"/users/show.html"   
  end

  delete "/users/:id" do
    @user == current_user
      @user = User.find(params[:id])
      @user.destroy
      session.clear
      redirect "/"
  end

end
