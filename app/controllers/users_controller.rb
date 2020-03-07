class UsersController < ApplicationController

  # GET: /users
  get "/users" do
    erb :"/users/index.html"
  end

  #CREATE
  get "/users/create_account" do
    if logged_in?
       redirect "/users/#{current_user.id}"
    end
    erb :"/users/create_account.html"
  end

  # POST: /users
  post "/users" do
    if !User.all.find_by(username: params[:username]) && !params.emtpy?
      user = User.create(params)
      session[:user_id] = user.id
      redirect "/users/#{user.id}"
    else
      redirect "/users/create_account"
    end
  end

  get '/login' do 
    if logged_in?
      redirect "/users/#{current_user.id}"
    end
    erb :"/users/login.html"
  end

  post '/login' do 
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    end
  end

  #READ
  get "/users/:id" do
    erb :"/users/collection.html"
  end

  # GET: /users/5/edit
  get "/users/:id/edit" do
    erb :"/users/edit.html"
  end

  # PATCH: /users/5
  patch "/users/:id" do
    redirect "/users/:id"
  end

  # DELETE: /users/5/delete
  delete "/users/:id/delete" do
    redirect "/users"
  end

  get '/logout' do 
    if logged_in? && (session[:user_id] > 0)
      session.clear 
      redirect "/"
    end
  end
end
