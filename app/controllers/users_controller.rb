class UsersController < ApplicationController
  
  get "/users/new" do
    if logged_in?
      flash[:error] = "You are already logged in. No need to create an account."
       redirect "/users/#{current_user.id}"
    end
    erb :"/users/new.html"
  end

  post "/users" do
      @user = User.create(params)
      if @user.errors.any?
        @user.errors.full_messages.each do |message|
          flash[:error] = "#{message}"
          redirect "/users/new"
        end
      else
        session[:user_id] = @user.id
        redirect "/users/#{@user.id}"
      end
  end

  get "/users/login" do
    if logged_in?
      redirect "/users/#{current_user.id}"
    end
    erb :"/users/login.html"
  end

  post '/users/login' do
    @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect "/users/#{@user.id}"
    else
      flash[:error] = "Login error!!!  Please create an account."
      redirect "/users/new"
    end
  end
  
  get '/users/collection' do 
    if !logged_in?
      flash[:error] = "Please Sign In To View Collection"
      redirect "/users/login"
    end
    @sorted_bottles = current_user.bottles.order(name: :asc)
    erb :"/users/collection.html"
  end

  get '/users/logout' do 
    if logged_in? && (session[:user_id] > 0)
      session.clear 
      redirect "/users/login"
    end
  end

  get "/users/:id" do
    @user = User.find_by(id: params[:id])
    if !@user
      flash[:error] = "User does not exist"
      redirect "/users/login"
    end
    erb :"/users/show.html"   
  end

  delete "/users/:id" do
    @user = User.find_by(id: params[:id])
    @user == current_user
      @user.destroy
      session.clear
      redirect "/users/login"
  end

end